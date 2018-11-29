import 'package:flutter/material.dart';

class MySharePage extends StatefulWidget {
  MyShareState createState() => MyShareState();
}

class MyShareState extends State {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的分享码'),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            child: new Image.asset(
              'assets/share.jpg',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          new Container(
            child: new Image.asset('assets/qrcode.png',width: 130.0,height: 130.0,),
            margin: new EdgeInsets.only(top: 288.0),
            alignment: Alignment(0.0, 0.0)

          ),

        ],
      ),
    );
  }
}
