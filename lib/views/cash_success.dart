import 'package:flutter/material.dart';

class CashSuccessPage extends StatefulWidget {
  @override
  CashSuccessState createState() => CashSuccessState();
}

class CashSuccessState extends State {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('申请成功'),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.only(top: 50.0,bottom:30.0),
            child: new Column(
              children: <Widget>[
                new Center(
                  child: new Column(
                    children: <Widget>[
                      Image.asset('assets/success.png'),
                      new Container(
                        margin: new EdgeInsets.only(top: 20.0),
                        child: new Text('提现申请成功',style: new TextStyle(color: Color.fromRGBO(158, 158, 158, 1)),),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 30.0),
            padding: new EdgeInsets.all(15.0),
            child: new RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/cash');
              },
              child: new Text('确定'),
              textColor: Color.fromRGBO(255, 255, 255, 1),
              color: Colors.blue[800],
            ),
          )
        ],
      ),
    );
  }
}
