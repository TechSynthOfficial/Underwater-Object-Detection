
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/choose.dart';
import 'package:untitled1/letsgo.dart';
import 'package:untitled1/login.dart';
import 'package:untitled1/models/Firebasehelper.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/showimage.dart';
import 'package:untitled1/start.dart';
import 'package:untitled1/startlogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser= FirebaseAuth.instance.currentUser;
  if(currentUser!=null){
    UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
    if(thisUserModel!=null){
      runApp(MainLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else{
      runApp(Main());
    }

  }
  else{
  runApp(Main());}
      // debugShowCheckedModeBanner: false,
      // // home: StartScreen(),
      // initialRoute: 'start',
      // routes: {
      //   'start': (context) => StartScreen(),
      //   'login': (context) => MyLogin(),
      //   // 'choose': (context) => ChooseImage(userMode,firebaseUser),
      //   'showimage': (context) => ShowImage(),
      // }


}

class Main extends StatelessWidget {


  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StartScreen(),
        initialRoute: 'startlogin',
        routes: {
          'startlogin': (context) => StartLogin(),
          'login': (context) => MyLogin(),
          // 'choose': (context) => ChooseImage(userMode,firebaseUser),
          // 'showimage': (context) => ShowImage(),
          'letsgo': (context) => LetsGo(),
        }
        );
  }
}

class MainLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MainLoggedIn({super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StartScreen(),
        initialRoute: 'start',
        routes: {
          'start': (context) => StartScreen(userModel: userModel, firebaseUser: firebaseUser),
          'login': (context) => MyLogin(),
          // 'choose': (context) => ChooseImage(userMode,firebaseUser),
          // 'showimage': (context) => ShowImage(),
          'letsgo': (context) => LetsGo(),
        }
    );
  }
}


