// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/choose.dart';
import 'package:untitled1/models/UIHelper.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/showimage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

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
          image: AssetImage('assets/2nd.jpeg'),fit: BoxFit.cover,opacity: 0.7,         // Default: 0.5

        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(

              padding: EdgeInsets.only(left: 30,top: 80),
              child: Text('Hi,\nWelcome',style: TextStyle(
                color: Colors.black,fontSize: 35

              ),)
              ,

            ),
            Container(
              padding: EdgeInsets.only(left: 190,top: 125),
              child: Icon(Icons.waving_hand,color: Colors.yellow,size: 30,
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 30,top: 170),
              child: Text('Tell us little about yourself to personalize\nto proceed further',style: TextStyle(
                  color: Colors.white,fontSize: 16,
              ),),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3,right: 30,left: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white54,
                        filled: true,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                    TextField(
                      controller: companycontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.white54,
                          filled: true,
                          hintText: 'Enter you Company',
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // TextField(
                    //   controller: researchercontroller,
                    //   decoration: InputDecoration(
                    //       fillColor: Colors.white30,
                    //       filled: true,
                    //       hintText: 'Are You Researcher? Yes/No',
                    //       hoverColor: Colors.white,
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10)
                    //       )
                    //   ),
                    // ),
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
                    Center(

                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: DropdownButton(

                              hint: Text('  Are You A Reseracher '),
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              iconEnabledColor: Colors.black,
                              isExpanded: true,
                              value: valueChose,
                              underline: Container(),
                              onChanged: (newValue){
                                setState(() {
                                  valueChose = newValue;
                                });
                              },

                              items: listitem.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                    child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                  ),
                ),
              ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   child: RichText(
                    //     text: TextSpan(
                    //       children: <TextSpan>[
                    //         TextSpan(text: 'Do you already gave your info to us?? ',),
                    //         TextSpan(text: '\nClick here',recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pushNamed(context, 'letsgo'),style: TextStyle(color: Colors.blue,fontSize: 18,))
                    //
                    //       ]
                    //     ),
                    //   )
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(onPressed:(){
                      checkValues();
                      // Navigator.pushNamed(context, 'choose');
                    },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,


                        fixedSize: Size(200, 50) ,
                        textStyle: TextStyle(fontSize: 19),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color: Colors.blue))
                      ),

                      child: Text('SIGN UP'),



                    ),

                    SizedBox(
                      height: 130,
                    ),
                    Container(

                        child: RichText(
                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Already have an account?? ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal)),
                                TextSpan(text: 'Login here',recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pushNamed(context, 'letsgo'),style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold))

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
