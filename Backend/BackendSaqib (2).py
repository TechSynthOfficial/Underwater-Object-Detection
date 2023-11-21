from keras import models
import numpy as np
import cv2
import torch
import psycopg2
import sys
from PIL import Image
import matplotlib.pyplot as plt
from psycopg2 import Error
import psycopg2.extras as extras
from flask import Flask,request,jsonify,send_file
from ultralytics import YOLO
import base64

#Connecting Database



conn = None
try:
    # connect to the PostgreSQL server
    print('Connecting to the PostgreSQL database...')
    conn = psycopg2.connect(**params_dic)
    if conn:
        print("DB Connected")
        cursor = conn.cursor()
except (Exception, psycopg2.DatabaseError) as error:
    print(error)
    sys.exit(1)

alllabels = [
    'Fish', 'Jellyfish', 'Penguin', 'Puffin', 'Shark', 'Starfish', 'Stingray'
]

objects=[]

def search_query(predvalue):

    objects.clear()
    for SQ in predvalue:
        query = "SELECT * FROM UndObject where name='%s'" % (SQ)
        try:
          cursor.execute(query)
          conn.commit()
          objec = cursor.fetchall()
        #   objects.append(objec)

          objects.append(objec[0][2])

        except (Exception, psycopg2.DatabaseError) as error:
          print("Error: %s" % error)
          conn.rollback()
    return objects


def load_yolo_model():
    model = torch.hub.load(" model path")
    return model

def calculate_contrast(image):
    # Calculate standard deviations of each channel
    std_dev_R = np.std(image[:, :, 0])
    std_dev_G = np.std(image[:, :, 1])
    std_dev_B = np.std(image[:, :, 2])

    # Calculate contrast as the average of standard deviations
    contrast = (std_dev_R + std_dev_G + std_dev_B) / 3
    return contrast

def equalize_rgb(image):
    # Convert the image to LAB color space
    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    lab_image = cv2.cvtColor(image, cv2.COLOR_BGR2LAB)

    # Split the LAB image into L, A, and B channels
    l_channel, a_channel, b_channel = cv2.split(lab_image)

    # Apply histogram equalization to the L channel
    clahe = cv2.createCLAHE(clipLimit=3.0, tileGridSize=(8, 8))
    equalized_l_channel = clahe.apply(l_channel)

    # Merge the equalized L channel with the original A and B channels
    equalized_lab_image = cv2.merge((equalized_l_channel, a_channel, b_channel))

    # Convert the LAB image back to RGB color space
    equalized_rgb_image = cv2.cvtColor(equalized_lab_image, cv2.COLOR_LAB2RGB)

    return equalized_rgb_image


def yolopred(model,image_path):
    image = cv2.imread(image_path)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    contrast_value = calculate_contrast(image)

    if contrast_value >= 40:
        equalized_image = equalize_rgb(image)
        image1 = cv2.resize(equalized_image, (640, 640), interpolation = cv2.INTER_CUBIC)
        result = model(image1)
        boundingbox = result.render()[0]
        return boundingbox,result
    else:
        image1 = cv2.resize(image, (640, 640), interpolation = cv2.INTER_CUBIC)
        result = model(image1)
        boundingbox = result.render()[0]
        return boundingbox,result

        
def extract_label(result):
    print(result)
    pd = result.pandas().xyxy[0]
    print(pd)
    labelid = pd['class']
    labelids=[]
    for i in range(len(labelid)):
        labelids.append(labelid[i])
    label_values = []
    for i in (labelids):
        label_values.append(alllabels[i])
    print("Label_values: ",label_values)
    return label_values



model2 = load_yolo_model()

app = Flask(__name__)
@app.route('/predict', methods=['POST'])
def predict():
    file = request.files['image']
    completepath = ""
    file.save(completepath)
    boundingbox, result = yolopred(model2, completepath)
    cv2.imwrite('',boundingbox)
    pred=[]
    pred = extract_label(result)
    print(len(boundingbox))
    print(pred)
    if len(pred)!=0:
        predobj=[]
        for i in range(len(pred)):
           if pred[i] not in predobj:
              predobj.append(pred[i])
        print(predobj)
        result=[]
        result=search_query(predobj)
        print(result)
        return jsonify({"label": predobj, "objects": result,})
    
    else: 
        return jsonify({"label": ['Out of Range'], "objects": ['Ooopss Sorry!! We did not find anything to detect. We can only detect these species [Fish, Jellyfish, Penguin, Puffin, Shark, Starfish, Stingray]'],})

  




@app.route('/image')
def get_image():
    return send_file('', mimetype='image/jpg')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
