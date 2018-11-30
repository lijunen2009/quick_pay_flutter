import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class Common {

  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Center(child: new CupertinoActivityIndicator(
            animating: true, radius: 30.0,));
        }
    );
  }

  static void closeLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static Future checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if(token.isEmpty){
      Navigator.of(context).pushReplacementNamed('login');
    }else{
      return true;
    }
  }

  static Future getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return json.decode(token);
  }
}

