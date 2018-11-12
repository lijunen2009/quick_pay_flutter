import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  Widget toper = Stack(
    alignment: const Alignment(0.6, 1),
    children: <Widget>[
      new Container(
        color: Colors.lightBlue[800],
        height: 270,
        padding: new EdgeInsets.only(
            top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset('assets/head.png'),
              ],
            ),
            new Container(
              margin: new EdgeInsets.only(left: 15.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    '李俊恩',
                    textAlign: TextAlign.start,
                    style: new TextStyle(color: Colors.white),
                  ),
                  new Text(
                    '15598045566',
                    textAlign: TextAlign.start,
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      new Container(
        // color: Colors.lightBlueAccent,
        padding: new EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
        margin: new EdgeInsets.only(left: 30.0, right: 30.0),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(3.0)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Text(
                    '今日首页',
                    style:
                        new TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                  ),
                  new Text(
                    '0',
                    style: new TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Text('钱包余额',
                      style: new TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1))),
                  new Text(
                    '100',
                    style: new TextStyle(color: Colors.red),
                  )
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
  Widget module = new Container(
    color: Color.fromRGBO(255, 255, 255, 1),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Image.asset(
                'assets/auth.png',
                width: 40.0,
                height: 40.0,
              ),
              new Container(
                margin: new EdgeInsets.only(top: 20.0),
                child: new Text('实名认证'),
              )
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.all(20.0),
          // decoration: new BoxDecoration(
          //     border: Border(left: BorderSide(color: Color.fromRGBO(204, 204, 204, 1), width: 1.0),right: BorderSide(color:Color.fromRGBO(204, 204, 204, 1),width: 1.0))),
          child: new Column(
            children: <Widget>[
              new Image.asset(
                'assets/group.png',
                width: 40.0,
                height: 40.0,
              ),
              new Container(
                margin: new EdgeInsets.only(top: 20.0),
                child: new Text('我的推荐'),
              )
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Image.asset(
                'assets/recommend.png',
                width: 40.0,
                height: 40.0,
              ),
              new Container(
                margin: new EdgeInsets.only(top: 20.0),
                child: new Text('我的推荐码'),
              )
            ],
          ),
        )
      ],
    ),
  );



  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[toper, module],
    );
  }
}
