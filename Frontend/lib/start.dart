import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/choose.dart';
import 'package:untitled1/models/Firebasehelper.dart';
import 'package:untitled1/models/userModel.dart';

import 'login.dart';
class StartScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const StartScreen({super.key, required this.userModel, required this.firebaseUser});


  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds:2), () {

    User? currentUser = FirebaseAuth.instance.currentUser;
    // UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
    // if(currentUser!=null) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){

            return ChooseImage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          }));
    // }


     // Navigator.push(
     //      context,
     //      MaterialPageRoute(builder: (context){
     //    return MyLogin();
     //  }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/1st.jpeg'),fit: BoxFit.cover,
            ),
        ),
      )
    );

  }
}
