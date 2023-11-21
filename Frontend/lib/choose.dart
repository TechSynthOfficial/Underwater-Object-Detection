import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/models/UIHelper.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/showimage.dart';
import 'dart:typed_data';

class ChooseImage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const ChooseImage({Key? key,required this.userModel,required this.firebaseUser}): super(key: key);

  // const ChooseImage({Key? key}) : super(key: key);

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {

  File? imageFile;
  // String _prediction = '';
  // String _lable='';
  var _ingred= [];
  // var _meth= [];
  var _detectedObjects = [];
  late Uint8List _imagebytes;





//   ChooseImage(){
//     this.imageFile!;
// }
//
  void checkValues(){
    // if(imageFile==null){
    //   Fluttertoast.showToast(msg: 'Please Fill all the fields');
    //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please choose the image")));
    // }
    // else{
      uploadPic();
    // }
  }

  void uploadPic() async{
    if(imageFile==null){
      Fluttertoast.showToast(msg: 'Please Choose the Image!!');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please choose the image")));
    }
    else {
      _detectObjects();
      UIHelper.showLoadingDialog(context, "Wait for a While...");
      UploadTask uploadTask = FirebaseStorage.instance.ref("pics").child(
          widget.userModel.Uid.toString()).putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String? imageURL = await snapshot.ref.getDownloadURL();

      widget.userModel.Pic = imageURL;

      await FirebaseFirestore.instance.collection("users").doc(
          widget.userModel.Uid).set(widget.userModel.toMap()).then((value) {
        // Navigator.pushNamed(context, 'showimage');
        // if (_imagebytes.isEmpty){
        //   Fluttertoast.showToast(msg: 'Please Choose the Image!!');
        //
        //
        //
        // }
        // else {
        Future.delayed(Duration(seconds: 11), () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ShowImage(userModel: widget.userModel,
                    firebaseUser: widget.firebaseUser,objects :_detectedObjects,desc: _ingred, imageData: _imagebytes );
              }));
        });

        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) {
        //         return ShowImage(userModel: widget.userModel,
        //             firebaseUser: widget.firebaseUser,objects :_detectedObjects,desc: _ingred, imageData: _imagebytes );
        //       }));
        // }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) {
        //       return ShowImage(userModel: widget.userModel,
        //           firebaseUser: widget.firebaseUser,objects :_detectedObjects,desc: _ingred, imageData: _imagebytes );
        //     }));
      });
    }
  }


  void selectimage(ImageSource source) async{
    XFile? selectedImage=await ImagePicker().pickImage(source: source);
    if(selectedImage!=null){
      cropImage(selectedImage);
    }
  }

  void cropImage(XFile file) async{
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20

    );

    if(croppedImage!=null){
      setState(() {
        // yourfile = File(croppedImage!.path);
        imageFile=File(croppedImage!.path);
      });
    }
  }
  void showoptions(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Upload Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(

              onTap: (){
                Navigator.pop(context);
                selectimage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo_album),
              title: Text('Gallery'),
            ),
            ListTile(

              onTap: (){
                Navigator.pop(context);
                selectimage(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
            )
          ],
        ),
      );
    });
  }

  Future<void> _detectObjects() async {
    // Send the image file to the API endpoint
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.123.238:5000/predict'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile!.path));
    var response = await request.send();

    // Decode the response JSON
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var json = jsonDecode(jsonString);
      // print (json);
      //  // user = jsonDecode(jsonString);
      //
      // print('${json['label']}!');
      // print('${json['objects']}.');

      // Set the detected objects in the state
      setState(() {
        // _prediction=json['label'];
        _detectedObjects=json['label'];
        _ingred=json['objects'];
        // _meth=json['method'];
        // final encode=
        // imagebytes = json['image'];
        // print(_prediction);
        print(_detectedObjects);
        print(_ingred);
        // print(_meth);
        // print(_lable);
        // _detectedObjects = json;
        // print (_detectedObjects);
        _fetchImage();
      });
    }
    else {
      throw Exception('Failed to load prediction');
    }

  }

  Future<void> _fetchImage() async {
    final response = await http.get(Uri.parse('http://192.168.123.238:5000/image'));
    setState(() {
      // if (_imagebytes!=null){_imagebytes = response.bodyBytes;}
      _imagebytes = response.bodyBytes;
    });
  }

  // Future<void> _detectObjects() async {
  //   // Send the image file to the API endpoint
  //   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.0.107:5000/predict'));
  //   request.files.add(await http.MultipartFile.fromPath('image', imageFile!.path));
  //   var response = await request.send();
  //
  //   // Decode the response JSON
  //   if (response.statusCode == 200) {
  //     var jsonString = await response.stream.bytesToString();
  //     var json = jsonDecode(jsonString);
  //     // print (json);
  //     //  // user = jsonDecode(jsonString);
  //     //
  //     // print('${json['label']}!');
  //     // print('${json['objects']}.');
  //
  //     // Set the detected objects in the state
  //     setState(() {
  //       _prediction=json['label'];
  //       _lable=json['objects'];
  //       print(_prediction);
  //       print(_lable);
  //       // _detectedObjects = json;
  //       // print (_detectedObjects);
  //     });
  //   }
  //   else {
  //     throw Exception('Failed to load prediction');
  //   }
  // String? valueChose;
  // final listitem=[
  //   'Detect The Image','Enhance the Image'
  // ];

  @override
  Widget build(BuildContext context) {

    // Navigator.of(context).pop(false);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/2nd.jpeg'),fit: BoxFit.cover,opacity: 0.7,
          )
      ),

      child: Center(
        // child: Scaffold(
        //   backgroundColor: Colors.transparent,

        child: Column(

              children: [
                // SizedBox(height: 80),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.15,
                  // padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1,),
                  child: Text("Upload your Picture here",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18,decoration: TextDecoration.none),textAlign: TextAlign.center,),
                  alignment: Alignment.center,

                ),
                //  SizedBox(height: 30),

                Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white30,


        ),
        // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,right: 10,left: 10),
         width: MediaQuery.of(context).size.width*0.85,
         height: MediaQuery.of(context).size.height*0.45,
        // alignment: Alignment.center,

        child:  imageFile==null ? Container(

           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(25),
               color: Colors.white30,


               ),
               // ,color: Colors.blue



            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,right: 10,left: 10),
            height: 450,
            width: 300,
            alignment: Alignment.center,
            // color: Colors.white54,


            child:Column(
                children: [
                  CupertinoButton(
                    onPressed: (){
                      showoptions();
                    },
                    child: CircleAvatar(

                      radius: 70,
                      // backgroundImage:(imageFile !=null) ? FileImage(imageFile!): null,
                      backgroundColor: Colors.white54,
                      child: (imageFile ==null) ? Icon(Icons.camera_alt,size: 55,color: Colors.black,):null,
                    ),
                  ),
                

                ],
              )
            ):Image.file(imageFile!,fit: BoxFit.contain,),
                ),
                SizedBox(height: 20),

                ElevatedButton(onPressed:(){
        showoptions();
        // Navigator.pushNamed(context, 'choose');
                },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,


            fixedSize: Size(200, 50) ,
            textStyle: TextStyle(fontSize: 19),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
        ),

        child: Text('Choose Image'),



                ),
                SizedBox(height: 170),
               
                SizedBox(height:5),
                Container(
        padding: EdgeInsets.only(right: 20,left: 220 ),
        child: ElevatedButton.icon(
          label: Icon(Icons.arrow_forward),
          icon: Text('NEXT'),

          onPressed:(){
            // _detectObjects();
            checkValues();

          },
          style: ElevatedButton.styleFrom(

              fixedSize: Size(160, 50) ,
              textStyle: TextStyle(fontSize: 19),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
          ),



        ),
                ),
        ]),
        ),
              // Container(
              //   padding: EdgeInsets.only(top:160,right: 20,left: 220 ),
              //   child: ElevatedButton.icon(
              //     label: Icon(Icons.arrow_forward),
              //     icon: Text('NEXT'),
              //
              //     onPressed:(){
              //       checkValues();
              //       // if(imageFile!=null){
              //       //   Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new ShowImage(
              //       //
              //       //   )));
              //       // }
              //       // Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new ShowImage()));
              //
              //   },
              //     style: ElevatedButton.styleFrom(
              //
              //         fixedSize: Size(160, 50) ,
              //         textStyle: TextStyle(fontSize: 19),
              //         backgroundColor: Colors.transparent,
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.blue))
              //     ),
              //
              //
              //
              //   ),
              // ),

              // Container(
              //   padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.92,right: 40,left: 20 ),
              //   child: ElevatedButton.icon(
              //
              //     label: Text('BACK'),
              //     icon: Icon(Icons.arrow_back),
              //     onPressed:(){
              //       Navigator.pushNamed(context, 'login');
              //     },
              //     style: ElevatedButton.styleFrom(
              //
              //         fixedSize: Size(120, 50) ,
              //         textStyle: TextStyle(fontSize: 19),
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
              //     ),
              //
              //
              //
              //   ),
              // ),

      // ],

        // ),
      );

    // );
  }
}
