import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/choose.dart';
import 'package:untitled1/login.dart';
import 'package:untitled1/starter.dart';


import 'details.dart';
import 'models/userModel.dart';
class ShowImage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  final List<dynamic> objects;
  final List<dynamic> desc;
  final Uint8List imageData;

  const ShowImage({super.key, required this.userModel, required this.firebaseUser, required this.objects, required this.desc, required this.imageData});


  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  // var path;

  // get path => null;


  // String url=widget.userModel.Pic.toString();
  void save() async{

    // final result = await ImageGallerySaver.saveImage(widget.imageData);
    // if (result['isSuccess']) {
    //   print('Image saved successfully');
    // }

    // String imageUrl=widget.imageData.toString();
    try {
    //     // Show a toast message to indicate that the image is being downloaded
        Fluttertoast.showToast(msg: 'Downloading image...');
        final result = await ImageGallerySaver.saveImage(widget.imageData);
    //     // Send a GET request to the URL to download the image
    //     final response = await http.get(Uri.parse(imageUrl));
    //     // Get the temporary directory
    //     final directory = await getTemporaryDirectory();
    //     // Create a file in the temporary directory
    //     final file = File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
    //     // Write the downloaded image to the created file
    //     await file.writeAsBytes(response.bodyBytes);
    //     // Save the image to the gallery
    //     final result = await ImageGallerySaver.saveFile(file.path);
        if (result['isSuccess']) {
          Fluttertoast.showToast(msg: 'Image saved to gallery.');
        } else {
          Fluttertoast.showToast(msg: 'Failed to save image to gallery.');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error: $e');
      }




    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: source)
    // if(widget.userModel.Pic!=null){
    //   final directory = await getTemporaryDirectory();
      // final file = File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      // await widget.userModel.Pic.copy(file.path);
      // final result = await GallerySaver.saveImage(file.path);
    }
    // String url='https://firebasestorage.googleapis.com/v0/b/uod-p-ee9e0.appspot.com/o/pics%2FLYusaOA8m6aF7pK63KRtASamXyi1?alt=media&token=4da13675-43b1-4681-97f6-4da84613f4a1';
    // final tempdir= await getTemporaryDirectory();
    // final path = '${tempdir.path}/myFlie.png';
    // await Dio().download(url, path);
    // await GallerySaver.saveImage(path);
      // await ImageG.saveImage(widget.userModel.Pic.toString(),toDcim:true,albumName:'Flutter');


  // late File imag;
  // ShowImage(){
  //   this.imag;
  // }
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
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
                padding: EdgeInsets.only(left: 20,right:20,top: 80),
                child: Text("Here's your Detected Image",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18,decoration: TextDecoration.none),textAlign: TextAlign.center,),
                alignment: Alignment.center,

              ),
              SizedBox(height: 30),

              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white30,

                ),

                // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                width: MediaQuery.of(context).size.width*0.85,
         height: MediaQuery.of(context).size.height*0.45,
                child:  widget.imageData==null ? Container(

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


                    // child:Column(
                    //   children: [
                    //     CupertinoButton(
                    //       onPressed: (){
                    //         showoptions();
                    //       },
                    //       child: CircleAvatar(
                    //
                    //         radius: 70,
                    //         // backgroundImage:(imageFile !=null) ? FileImage(imageFile!): null,
                    //         backgroundColor: Colors.white54,
                    //         child: (imageFile ==null) ? Icon(Icons.camera_alt,size: 55,color: Colors.black,):null,
                    //       ),
                    //     ),
                    //     // SizedBox(
                    //     //   height: 20,
                    //     // ),
                    //
                    //     //ElevatedButton(child: Text("Select Image from gallery ",style: TextStyle(fontSize: 20),)),
                    //     // ElevatedButton(onPressed:(){
                    //     //   showoptions();
                    //     // },
                    //     //   style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
                    //     //
                    //     //       fixedSize: Size(200, 50) ,
                    //     //       textStyle: TextStyle(fontSize: 19),
                    //     //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                    //     //   ),
                    //     //
                    //     //   child: Text('CHOOSE IMAGE'),
                    //     // ),
                    //     // SizedBox(
                    //     //   height: 145,
                    //     // ),
                    //
                    //   ],
                    // )
                ):Image.memory(widget.imageData!,fit: BoxFit.contain,),

                // alignment: Alignment.center,

                // child:  imageFile==null ? Container(
                //
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(25),
                //       color: Colors.white30,
                //
                //
                //     ),
                //     // ,color: Colors.blue
                //
                //
                //
                //     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,right: 10,left: 10),
                //     height: 450,
                //     width: 300,
                //     alignment: Alignment.center,
                //     // color: Colors.white54,
                //
                //
                //     child:Column(
                //       children: [
                //         CupertinoButton(
                //           onPressed: (){
                //             showoptions();
                //           },
                //           child: CircleAvatar(
                //
                //             radius: 70,
                //             // backgroundImage:(imageFile !=null) ? FileImage(imageFile!): null,
                //             backgroundColor: Colors.white54,
                //             child: (imageFile ==null) ? Icon(Icons.camera_alt,size: 40,color: Colors.black,):null,
                //           ),
                //         ),
                //         // SizedBox(
                //         //   height: 20,
                //         // ),
                //
                //         //ElevatedButton(child: Text("Select Image from gallery ",style: TextStyle(fontSize: 20),)),
                //         // ElevatedButton(onPressed:(){
                //         //   showoptions();
                //         // },
                //         //   style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
                //         //
                //         //       fixedSize: Size(200, 50) ,
                //         //       textStyle: TextStyle(fontSize: 19),
                //         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                //         //   ),
                //         //
                //         //   child: Text('CHOOSE IMAGE'),
                //         // ),
                //         // SizedBox(
                //         //   height: 145,
                //         // ),
                //
                //       ],
                //     )
                // ):Image.file(imageFile!,fit: BoxFit.contain,),
              ),
              SizedBox(height: 20),

              ElevatedButton(onPressed:() async{
                // final result = await GallerySaver.saveImage(widget.imageData.toString());
                save();
              },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,


                    fixedSize: Size(200, 50) ,
                    textStyle: TextStyle(fontSize: 19),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                ),

                child: Text('Save Image'),



              ),
              SizedBox(height: 20),


              Container(
                padding: EdgeInsets.only(top:150,right: 10,left: 30 ),
                child: Row(

                  children:

                  [Container(
                    child: ElevatedButton.icon(

                        label: Text('BACK'),
                        icon: Icon(Icons.arrow_back),
                        onPressed:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ChooseImage(userModel: widget.userModel,
                                    firebaseUser: widget.firebaseUser);
                              }));
                        },
                        style: ElevatedButton.styleFrom(

                            fixedSize: Size(120, 50) ,
                            textStyle: TextStyle(fontSize: 19),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                        ),



                      ),
                  ),



                 SizedBox(width: 40),

                    Container(
                      // padding: EdgeInsets.only(right: 20,left: 220 ),
                      child: ElevatedButton.icon(
                        label: Icon(Icons.arrow_forward),
                        icon: Text('View Details'),

                        onPressed:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Details(userModel: widget.userModel,
                                    firebaseUser: widget.firebaseUser,objects :widget.objects,desc: widget.desc, imageData: widget.imageData);
                              }));
                          // _detectObjects();
                          ;

                        },
                        style: ElevatedButton.styleFrom(

                            fixedSize: Size(150, 50) ,
                            textStyle: TextStyle(fontSize: 19),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                        ),



                      ),
                    ),

                 // Container(
                 //
                 //   child: ElevatedButton.icon(
                 //
                 //      label: Text('EXIT'),
                 //      icon: Icon(Icons.exit_to_app),
                 //      onPressed:() async{
                 //        showDialog(context: context, builder: (context){
                 //          return AlertDialog(
                 //            // backgroundColor: Colo,
                 //            title: Text("Do You want to Exit??"),
                 //            content: Text("If you exit now, then next time you'll be give your eamil again\n\nThanks for visiting us"),
                 //            actions: <Widget>[
                 //              ElevatedButton(onPressed: ()async{
                 //                // await FirebaseAuth.instance.signOut();
                 //                Navigator.pop(context);
                 //
                 //              }, child: Text("No")),
                 //              ElevatedButton(onPressed: ()async{
                 //                await FirebaseAuth.instance.signOut();
                 //                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                 //                  return mainPage();
                 //                }),);
                 //              }, child: Text("Yess")),
                 //
                 //            ],
                 //          );
                 //        });
                 //       // await FirebaseAuth.instance.signOut();
                 //       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                 //       //   return MyLogin();
                 //       // }),);
                 //      },
                 //      style: ElevatedButton.styleFrom(
                 //
                 //          fixedSize: Size(120, 50) ,
                 //          textStyle: TextStyle(fontSize: 19),
                 //          backgroundColor: Colors.transparent,
                 //          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                 //      ),
                 //
                 //
                 //
                 //    ),
                 // ),
    ]),
              ),

              // Material(
              //
              //   color: Colors.transparent,
              //   // padding: const EdgeInsets.only(left: 20,right: 20),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20,right: 20),
              //     child: Container(
              //
              //       decoration: BoxDecoration(
              //           color: Colors.white30,
              //           border: Border.all(color: Colors.black),
              //           borderRadius: BorderRadius.circular(10)
              //       ),
              //
              //       child: DropdownButton(
              //
              //         hint: Text('  What Do you want?? '),
              //         dropdownColor: Colors.white,
              //         icon: Icon(Icons.arrow_drop_down),
              //         iconSize: 36,
              //         iconEnabledColor: Colors.black,
              //         isExpanded: true,
              //         value: valueChose,
              //         underline: Container(),
              //         onChanged: (newValue){
              //           setState(() {
              //             valueChose = newValue;
              //           });
              //         },
              //
              //         items: listitem.map((valueItem) {
              //           return DropdownMenuItem(
              //             value: valueItem,
              //             child: Text(valueItem),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ),
              // ),
              // ElevatedButton(onPressed:(){
              //   showoptions();
              //   // Navigator.pushNamed(context, 'choose');
              // },
              //   style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
              //
              //
              //       fixedSize: Size(200, 50) ,
              //       textStyle: TextStyle(fontSize: 19),
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
              //   ),
              //
              //   child: Text('Enhance Image'),
              //
              //
              //
              // ),
              // SizedBox(height: 80),
              // Container(
              //   padding: EdgeInsets.only(right: 20,left: 220 ),
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
              //     },
              //     style: ElevatedButton.styleFrom(
              //
              //         fixedSize: Size(160, 50) ,
              //         textStyle: TextStyle(fontSize: 19),
              //         backgroundColor: Colors.transparent,
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
              //     ),
              //
              //
              //
              //   ),
              // ),
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
