import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Common{

  static void showLoading(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context){
          return new Center(child:new CupertinoActivityIndicator(animating: true,radius: 30.0,) );
        }
    );
  }


  static void closeLoading(BuildContext context){
    Navigator.pop(context);
  }

  static checkLogin(){

  }
}

