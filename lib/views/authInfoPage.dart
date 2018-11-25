import 'package:flutter/material.dart';
class AuthInfoPage extends StatefulWidget{
  
  AuthInfoState createState()=>AuthInfoState();
}

class AuthInfoState extends State<AuthInfoPage>{
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('实名认证'),centerTitle: true,),
      body: new ListView(
        children: <Widget>[
          new GestureDetector(
            child: new Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              margin: new EdgeInsets.all(10.0),
              padding: new EdgeInsets.only(top:15.0,bottom: 20.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/identify.png',

                  ),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text('个人信息认证',style: new TextStyle(color: Color.fromRGBO(33, 150, 243, 1),fontSize: 22),),
                        new Text('(未认证)',style: new TextStyle(color: Color.fromRGBO(244, 67, 54, 1),fontSize: 22),)
                      ],
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0),
                    child: new Text('提交个人真实姓名、身份证号'),
                  )
                ],
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed('/auth_identify');
            },
          ),
          new GestureDetector(
            child: new Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              margin: new EdgeInsets.all(10.0),
              padding: new EdgeInsets.only(top:15.0,bottom: 20.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/card.png',

                  ),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text('收款账号认证',style: new TextStyle(color: Color.fromRGBO(33, 150, 243, 1),fontSize: 22),),
                        new Text('(未认证)',style: new TextStyle(color: Color.fromRGBO(244, 67, 54, 1),fontSize: 22),)
                      ],
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0),
                    child: new Text('提交收款账号详细信息'),
                  )
                ],
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed('/auth_card');
            },
          )
        ],
      ),
    );
  }
}