import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:quick_pay/util/ToastUtil.dart';
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

  static Future checkLogin(BuildContext context,{bool isJump = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if(token == null || token.isEmpty){
      if(isJump){
        Navigator.of(context).pushReplacementNamed('login');
      }else{
        return false;
      }

    }else{
      return true;
    }
  }

  static Future getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return json.decode(token);
  }

  static checkNetwork() async{
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return 'mobile';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return 'wifi';
    }else{
      ToastUtil.showLongToast('无网络连接，请检查网络设置');
      return 'no_network';
    }
  }



}

