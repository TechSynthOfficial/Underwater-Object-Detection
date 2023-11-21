// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/choose.dart';
import 'package:untitled1/models/UIHelper.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/showimage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LetsGo extends StatefulWidget {

  const LetsGo({Key? key}) : super(key: key);

  @override
  State<LetsGo> createState() => _LetsGoState();
}

class _LetsGoState extends State<LetsGo> {

  TextEditingController emailcontroller = TextEditingController();

  void checkValues() {
    String email = emailcontroller.text.trim();


    if (email == "") {
      Fluttertoast.showToast(msg: 'Please Enter your Valid Email!!');
    }
    else {
      submit(email);
    }
  }

  void submit(String email) async {
    UserCredential? credential;
    UIHelper.showLoadingDialog(context, "We are getting you in>>");
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: 'UODp@123');
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      UIHelper.showAlertDialog(context, "An Error Occured", ex.message.toString());
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(ex.code.toString())));
    }


    if (credential != null) {
      // UIHelper.showLoadingDialog(context, "We are getting you in>>");
      String uid = credential.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection(
          'users').doc(uid).get();
      UserModel userModel = UserModel.fromMap(
          userData.data() as Map<String, dynamic>);

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChooseImage(
                userModel: userModel, firebaseUser: credential!.user!);
          })
      );
      //   });
      // }
    }}


    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/2nd.jpeg'),
              fit: BoxFit.cover,
              opacity: 0.7, // Default: 0.5

            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(

                padding: EdgeInsets.only(left: 30, top:MediaQuery
                    .of(context)
                    .size
                    .height * 0.08),
                child: Text('Hi,\nWelcome', style: TextStyle(
                    color: Colors.black, fontSize: 35

                ),)
                ,

              ),
              Container(
                padding: EdgeInsets.only(left: 190, top: 108),
                child: Icon(Icons.waving_hand, color: Colors.yellow, size: 30,
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 30,right: 20, top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2),
                child: Text(
                  'Kindly use the same email which you already used for this App',
                  style: TextStyle(
                    color: Colors.white, fontSize: 16,
                  ),),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3, right: 30, left: 30),
                  child: Column(
                    children: [

                      TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.white54,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Center(
                      //
                      //   child: Container(
                      //     child: DropDownFormField(
                      //
                      //       titleText: 'Are You Researcer?' ,
                      //       hintText: 'Please select one',
                      //       value: valueChose,
                      //       onChanged: (newValue){
                      //           setState(() {
                      //             valueChose = newValue;
                      //           });
                      //         },
                      //
                      //     ),
                      //   ),
                      // )
                      //       Center(
                      //
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(0.0),
                      //     child: Container(
                      //
                      //       decoration: BoxDecoration(
                      //         color: Colors.white30,
                      //         border: Border.all(color: Colors.black),
                      //         borderRadius: BorderRadius.circular(10)
                      //       ),
                      //       child: DropdownButton(
                      //
                      //                 hint: Text('  Are You A Reseracher '),
                      //                 dropdownColor: Colors.white,
                      //                 icon: Icon(Icons.arrow_drop_down),
                      //                 iconSize: 36,
                      //                 iconEnabledColor: Colors.black,
                      //                 isExpanded: true,
                      //                 value: valueChose,
                      //                 underline: Container(),
                      //                 onChanged: (newValue){
                      //                   setState(() {
                      //                     valueChose = newValue;
                      //                   });
                      //                 },
                      //
                      //                 items: listitem.map((valueItem) {
                      //                   return DropdownMenuItem(
                      //                     value: valueItem,
                      //                       child: Text(valueItem),
                      //                   );
                      //                 }).toList(),
                      //               ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),

                      ElevatedButton(onPressed: () {
                        checkValues();
                        // Navigator.pushNamed(context, 'choose');
                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,


                            fixedSize: Size(200, 50),
                            textStyle: TextStyle(fontSize: 19),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.blue))
                        ),

                        child: Text('LOGIN'),


                      ),

                      SizedBox(
                        height: 365,
                      ),

                      Container(

                          child: RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: "Don't have an account?? ",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal)),
                                  TextSpan(text: 'Signup here',recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pushNamed(context, 'login'),style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold))

                                ]
                            ),
                          )
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

}


