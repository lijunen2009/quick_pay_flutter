import 'package:flutter/material.dart';
import 'package:quick_pay/views/homePage.dart';
import 'package:quick_pay/views/authInfoPage.dart';
import 'package:quick_pay/views/auth_identify.dart';
import 'package:quick_pay/views/auth_card.dart';
import 'package:quick_pay/views/auth_detail.dart';
import 'package:quick_pay/views/cash.dart';
import 'package:quick_pay/views/wallet_log.dart';
import 'package:quick_pay/views/cash_log.dart';
import 'package:quick_pay/views/my_card.dart';
import 'package:quick_pay/views/my_team.dart';
import 'package:quick_pay/views/my_share.dart';
import 'package:quick_pay/views/login.dart';
import 'package:quick_pay/views/register.dart';
import 'package:quick_pay/views/login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool _isLogin = false;
  // This widget is the root of your application.
  @override
  _init(){
    if(_isLogin){
      return new HomePage();
    }else{
      return new LoginPage();
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homepage': (BuildContext context) => new HomePage(),
        '/auth_info': (BuildContext context) => new AuthInfoPage(),
        '/auth_identify': (BuildContext context) => new AuthIdentity(),
        '/auth_card': (BuildContext context) => new AuthCard(),
        '/auth_detail': (BuildContext context) => new AuthDetailPage(),
        '/cash': (BuildContext context) => new CashPage(),
        'wallet_log': (BuildContext context) => new WalletLogPage(),
        'cash_log': (BuildContext context) => new CashLogPage(),
        'my_card': (BuildContext context) => new MyCardPage(),
        'my_team':(BuildContext context)=>new MyTeamPage(),
        'my_share':(BuildContext context)=>new MySharePage(),
        'login':(BuildContext context)=>new LoginPage(),
        'register':(BuildContext context)=>RegisterPage()
      },
      title: '益点闪',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try imunning your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      home:_init(),
    );
  }
}
