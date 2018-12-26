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
import 'package:quick_pay/views/cash_success.dart';
import 'package:quick_pay/views/password.dart';
import 'package:quick_pay/views/splash_page.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/views/map.dart';
import 'package:quick_pay/views/map2.dart';
import 'package:quick_pay/views/draw_polyline.screen.dart';
import 'package:scoped_model/scoped_model.dart';
//void main() => runApp(MyApp());
class AppModel extends Model{
  int _count = 0;
  get count => _count;
  void increment(){
    _count++;
    notifyListeners();
  }
}

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State {
  //创建顶层状态
  AppModel  appModel = AppModel();

  @override
  initState() {
    super.initState();
    Common.checkNetwork();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: appModel,
        child: MaterialApp(
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
            'my_team': (BuildContext context) => new MyTeamPage(),
            'my_share': (BuildContext context) => new MySharePage(),
            'login': (BuildContext context) => new LoginPage(),
            'register': (BuildContext context) => new RegisterPage(),
            'cash_success': (BuildContext context) => new CashSuccessPage(),
            'password':(BuildContext context)=>PasswordPage(),
            'map':(BuildContext context)=>MapPage(),
            'map2':(BuildContext context)=>DrawPointScreen(),
            'drawling':(BuildContext context)=>DrawPolylineScreen()
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
          home: new SplashPage(),
        )
    );


  }
}
