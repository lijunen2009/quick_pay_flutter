import 'package:flutter/material.dart';
class MyCardPage extends StatefulWidget{
  MyCardState createState()=>MyCardState();
}
class MyCardState extends State{
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('我的银行卡'),),
      body: new Container(
        width: double.infinity,
        height: 100,
        decoration: new BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: Color.fromRGBO(71, 116, 208, 0.95)),
        margin: new EdgeInsets.all(15.0),
        padding:new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Text('招商银行',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
            ),
            new Container(
              margin: new EdgeInsets.only(top:10.0),
              child: new Text('储蓄卡',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
            ),
            new Container(
              margin: new EdgeInsets.only(top: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text('49494949999999999999999',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),textAlign: TextAlign.end,),
                ],
              )
            ),
          ],
        ),
      ),     
    );
  }
}