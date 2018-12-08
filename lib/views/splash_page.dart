import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:quick_pay/util/Common.dart';
class SplashPage extends StatefulWidget {
  SplashState createState() => SplashState();
}

class SplashState extends State {
  int timer = 4;
  bool _isLogin = false;
  @override
  initState(){
    super.initState();
    _setLoginState();
    _countDown();
  }

  _setLoginState() async {
    var flag = await Common.checkLogin(context, isJump: false);
    if (flag) {
      if(mounted) {
        setState(() {
          _isLogin = true;
        });
      }
    }
  }

  void _goHomePage(){
    if(_isLogin){
      Navigator.of(context).pushReplacementNamed('/homepage');
    }else{
      Navigator.of(context).pushReplacementNamed('login');
    }

  }
  void _countDown(){
    TimerUtil countDown = new TimerUtil();
    countDown.setInterval(1000);
    countDown.setTotalTime(3*1000);
    countDown.setOnTimerTickCallback((int value){
      if(mounted) {
        setState(() {
          timer = timer;
        });
      }
      timer--;
      if(timer == 1){
        _goHomePage();
      }


    });
    countDown.startCountDown();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Container(
          child: new Image.asset(
            'assets/start.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 30.0,right: 20.0),
          width: 60.0,
          height: 25.0,
          decoration: new BoxDecoration(color: Color.fromRGBO(153, 153, 153, 1),borderRadius: BorderRadius.circular(3.3)),
          child: new GestureDetector(
            child: new Center(
              child: new Text('跳过'+timer.toString(),
                style: new TextStyle(fontSize: 14,color: Color.fromRGBO(255, 255, 255, 1),),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: (){
              _goHomePage();
            },
          ),
        )
      ],
    ),
    );
  }
}
