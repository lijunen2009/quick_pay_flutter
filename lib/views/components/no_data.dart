import 'package:flutter/material.dart';
class NoDataPage extends StatelessWidget{
  Widget build(BuildContext context){
    return new Center(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: 60,bottom: 20),
            child: Image.asset('assets/no_data.png',width: 80,height: 80,),
          ),
          new Container(
            child: new Text('暂无数据',style: new TextStyle(color: Color.fromRGBO(158, 158, 158,1)),),
          )
        ],
      ),
    );
  }
}