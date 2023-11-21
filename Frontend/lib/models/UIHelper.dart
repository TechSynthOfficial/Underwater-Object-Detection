
import 'package:flutter/material.dart';

class UIHelper{

  static void showLoadingDialog(BuildContext context,String title){
    AlertDialog loadingDialog = AlertDialog(
      // backgroundColor: Colors.indigo,
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),

            SizedBox(height: 25,),
            Text(title),


          ],
        ),
      ),
    );

    showDialog(
        context: context,
        barrierDismissible: false,

        builder: (context){

            return loadingDialog;

    });
  }

  static void showAlertDialog(BuildContext context,title,String content){

    AlertDialog alertDialog=AlertDialog(
      // backgroundColor: Colors.redAccent,
        title: Text(title),
        content: Text(content),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Ok")
        )
      ],

    );

    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

}