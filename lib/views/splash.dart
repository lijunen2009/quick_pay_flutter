import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
class SplashPage extends StatefulWidget {
  SplashState createState() => SplashState();
}

class SplashState extends State {
  int timer = 3;
  @override
  initState(){
    super.initState();
    _countDown();
  }
  void _goHomePage(){
    Navigator.of(context).pushReplacementNamed('/homepage');
  }
  void _countDown(){
    TimerUtil countDown = new TimerUtil();
    countDown.setInterval(1000);
    countDown.setTotalTime(3*1000);
    countDown.setOnTimerTickCallback((int value){
      timer--;
      if(timer == 0){
        _goHomePage();
      }
      setState(() {
        timer = timer;
      });
    });
    countDown.startCountDown();
//    new Future.delayed(new Duration(seconds: 3),(){
//      _goHomePage();
//    });

  }

  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          child: new Image.asset(
            'assets/start.jpg',
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        new ClipOval(
          child: new Align(
            alignment: Alignment.topRight,
            child: new Container(
              width: 30.0,
              height: 30.0,
              decoration: new BoxDecoration(color: Colors.lightBlue),
              child: new Text(timer.toString(),style: new TextStyle(fontSize: 20,color: Colors.red),),
            ),
          ),
        )
      ],
    );
  }
}
