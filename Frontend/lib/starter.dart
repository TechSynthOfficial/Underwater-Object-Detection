// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/starter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/choose.dart';
import 'package:untitled1/models/UIHelper.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/showimage.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController companycontroller=TextEditingController();
  // DropdownSearch kkk=DropdownSearch();
  TextEditingController researchercontroller=TextEditingController();
  void checkValues(){
    String name=namecontroller.text.trim();
    String email=emailcontroller.text.trim();
    String company=companycontroller.text.trim();
    // String research=researchercontroller.text.trim();

    if(name==""||email==""||company==""||valueChose==""){
      // print("Please Fill all the fields");
      Fluttertoast.showToast(msg: 'Please Fill all the fields');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill all the fields")));
    }
    else{
      // print("Thanks for giving information");
      submit(email, name, company);
    }
  }

  void submit(String email,String name,String company) async{
    UserCredential? credential;
    UIHelper.showLoadingDialog(context, "Thanks For giving us Information");
    try {
      credential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: 'UODp@123');
    } on FirebaseAuthException catch(ex){
      Navigator.pop(context);
      UIHelper.showAlertDialog(context, "An Error Occured", ex.message.toString());
      // Fluttertoast.showToast(msg: ex.message.toString());
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }

    // UIHelper.showLoadingDialog(context, "Thanks For giving us Information");
    // Fluttertoast.showToast(msg: 'Thanks for giving information');
    if(credential!=null){
      String uid=credential.user!.uid;
      UserModel newUser=UserModel(
          Uid: uid,
          Name: name,
          Email: email,
          Company: company,
          Researcher: valueChose
      );

      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((value) {
        // Fluttertoast.showToast(msg: 'Thanks for giving information');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thanks for giving information")));
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return ChooseImage(userModel: newUser, firebaseUser: credential!.user!);
            })
        );
      });
    }
  }

  String? valueChose;
  final listitem=[
    'Yes','No'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1.png'),fit: BoxFit.cover,         // Default: 0.5

          )
      ),
      child: Center(
        // child: Scaffold(
        //   backgroundColor: Colors.transparent,

        child: Column(

            children: [
              // SizedBox(height: 80),
              // Container(
              //   padding: EdgeInsets.only(left: 20,right:20,top: 60),
              //   child: Text("Upload your Picture here",
              //     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18,decoration: TextDecoration.none),textAlign: TextAlign.center,),
              //   alignment: Alignment.center,
              //
              // ),
              // SizedBox(height: 30),

              // Container(
              //
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(25),
              //     color: Colors.white30,
              //
              //
              //   ),
              //   // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
              //   height: 350,
              //   width: 300,
              //   // alignment: Alignment.center,
              //
              //   child:Container(
              //
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25),
              //         color: Colors.white30,
              //
              //
              //       ),
              //       // ,color: Colors.blue
              //
              //
              //
              //       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,right: 10,left: 10),
              //       height: 450,
              //       width: 300,
              //       alignment: Alignment.center,
              //       // color: Colors.white54,
              //
              //
              //       child:Column(
              //         children: [
              //           CupertinoButton(
              //             onPressed: (){
              //               // showoptions();
              //             },
              //             child: CircleAvatar(
              //
              //               radius: 70,
              //               // backgroundImage:(imageFile !=null) ? FileImage(imageFile!): null,
              //               backgroundColor: Colors.white54,
              //               child: Icon(Icons.camera_alt,size: 55,color: Colors.black,),
              //             ),
              //           ),
              //           // SizedBox(
              //           //   height: 20,
              //           // ),
              //
              //           //ElevatedButton(child: Text("Select Image from gallery ",style: TextStyle(fontSize: 20),)),
              //           // ElevatedButton(onPressed:(){
              //           //   showoptions();
              //           // },
              //           //   style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
              //           //
              //           //       fixedSize: Size(200, 50) ,
              //           //       textStyle: TextStyle(fontSize: 19),
              //           //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
              //           //   ),
              //           //
              //           //   child: Text('CHOOSE IMAGE'),
              //           // ),
              //           // SizedBox(
              //           //   height: 145,
              //           // ),
              //
              //         ],
              //       )
              //   ),
              // ),
              SizedBox(height: 20),
              // Text("data",style: ,)

              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35,right: MediaQuery.of(context).size.width*0.5),
                child: ElevatedButton(onPressed:(){

                  // showoptions();
                  Navigator.pushNamed(context, 'letsgo');
                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,


                      fixedSize: Size(150, 50) ,
                      textStyle: TextStyle(fontSize: 19,),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                  ),

                  child: Text('Login'),



                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.5),
                  child: Text("Or",style: TextStyle(fontSize: 18,decoration: TextDecoration.none,color: Colors.white),)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.5),
                child: ElevatedButton(onPressed:(){
                  // showoptions();
                  Navigator.pushNamed(context, 'login');
                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,


                      fixedSize: Size(150, 50) ,
                      textStyle: TextStyle(fontSize: 19),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                  ),

                  child: Text('SignUp',),



                ),
              ),
              // SizedBox(height: 120),
              // Container(
              //   padding: EdgeInsets.only(right: 20,left: 220 ),
              //   child: ElevatedButton.icon(
              //     label: Icon(Icons.arrow_forward),
              //     icon: Text('NEXT'),
              //
              //     onPressed:(){
              //       checkValues();
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
      // child: Scaffold(
      //   backgroundColor: Colors.transparent,
      //   body: Stack(
      //     children: [
      //       Container(
      //
      //         padding: EdgeInsets.only(left: 30,top: 80),
      //         child: Text('Hi,\nWelcome',style: TextStyle(
      //             color: Colors.black,fontSize: 35
      //
      //         ),)
      //         ,
      //
      //       ),
      //       Container(
      //         padding: EdgeInsets.only(left: 190,top: 125),
      //         child: Icon(Icons.waving_hand,color: Colors.yellow,size: 30,
      //         ),
      //       ),
      //
      //       Container(
      //         padding: EdgeInsets.only(left: 30,top: 170),
      //         child: Text('Tell us little about yourself to personalize\nto proceed further',style: TextStyle(
      //           color: Colors.white,fontSize: 16,
      //         ),),
      //       ),
      //       SingleChildScrollView(
      //         child: Container(
      //           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.38,right: 30,left: 30),
      //           child: Column(
      //             children: [
      //               TextField(
      //                 controller: namecontroller,
      //                 decoration: InputDecoration(
      //                     fillColor: Colors.white54,
      //                     filled: true,
      //                     hintText: 'Name',
      //                     border: OutlineInputBorder(
      //                         borderRadius: BorderRadius.circular(10)
      //                     )
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               TextField(
      //                 controller: emailcontroller,
      //                 decoration: InputDecoration(
      //                     fillColor: Colors.white54,
      //                     filled: true,
      //                     hintText: 'Email',
      //                     border: OutlineInputBorder(
      //                         borderRadius: BorderRadius.circular(10)
      //                     )
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               TextField(
      //                 controller: companycontroller,
      //                 decoration: InputDecoration(
      //                     fillColor: Colors.white54,
      //                     filled: true,
      //                     hintText: 'Enter you Company',
      //                     hoverColor: Colors.white,
      //                     border: OutlineInputBorder(
      //                         borderRadius: BorderRadius.circular(10)
      //                     )
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               // TextField(
      //               //   controller: researchercontroller,
      //               //   decoration: InputDecoration(
      //               //       fillColor: Colors.white30,
      //               //       filled: true,
      //               //       hintText: 'Are You Researcher? Yes/No',
      //               //       hoverColor: Colors.white,
      //               //       border: OutlineInputBorder(
      //               //           borderRadius: BorderRadius.circular(10)
      //               //       )
      //               //   ),
      //               // ),
      //               // Center(
      //               //
      //               //   child: Container(
      //               //     child: DropDownFormField(
      //               //
      //               //       titleText: 'Are You Researcer?' ,
      //               //       hintText: 'Please select one',
      //               //       value: valueChose,
      //               //       onChanged: (newValue){
      //               //           setState(() {
      //               //             valueChose = newValue;
      //               //           });
      //               //         },
      //               //
      //               //     ),
      //               //   ),
      //               // )
      //               Center(
      //
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(0.0),
      //                   child: Container(
      //                     padding: const EdgeInsets.all(5),
      //                     decoration: BoxDecoration(
      //                         color: Colors.white54,
      //                         border: Border.all(color: Colors.black),
      //                         borderRadius: BorderRadius.circular(10)
      //                     ),
      //                     child: DropdownButton(
      //
      //                       hint: Text('  Are You A Reseracher '),
      //                       dropdownColor: Colors.white,
      //                       icon: Icon(Icons.arrow_drop_down),
      //                       iconSize: 36,
      //                       iconEnabledColor: Colors.black,
      //                       isExpanded: true,
      //                       value: valueChose,
      //                       underline: Container(),
      //                       onChanged: (newValue){
      //                         setState(() {
      //                           valueChose = newValue;
      //                         });
      //                       },
      //
      //                       items: listitem.map((valueItem) {
      //                         return DropdownMenuItem(
      //                           value: valueItem,
      //                           child: Text(valueItem),
      //                         );
      //                       }).toList(),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Container(
      //                   child: RichText(
      //                     text: TextSpan(
      //                         children: <TextSpan>[
      //                           TextSpan(text: 'Do you already gave your info to us?? ',),
      //                           TextSpan(text: '\nClick here',recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pushNamed(context, 'letsgo'),style: TextStyle(color: Colors.blue,fontSize: 18,))
      //
      //                         ]
      //                     ),
      //                   )
      //               ),
      //               SizedBox(
      //                 height: 50,
      //               ),
      //               ElevatedButton(onPressed:(){
      //                 checkValues();
      //                 // Navigator.pushNamed(context, 'choose');
      //               },
      //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
      //
      //
      //                     fixedSize: Size(200, 50) ,
      //                     textStyle: TextStyle(fontSize: 19),
      //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
      //                 ),
      //
      //                 child: Text('SUBMIT'),
      //
      //
      //
      //               )
      //
      //
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),

    );

  }
}
