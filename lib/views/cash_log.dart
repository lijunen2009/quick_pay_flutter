import 'package:flutter/material.dart';
class CashLogPage extends StatefulWidget{
  @override
  CashLogState createState()=>CashLogState();
}
class CashLogState extends State{
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('提现记录'),),
      body: ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('1111111111'),
            subtitle: new Text('2018-10-10'),
            trailing: new Column(
              children: <Widget>[
                new Text('5',style: new TextStyle(color: Colors.red,fontSize: 18),),
                new Text('提现成功',style: new TextStyle(color: Color.fromRGBO(150, 150, 150, 1)),)
              ],
            ),
          ),
          new Divider(),
          new ListTile(
            title: new Text('1111111111'),
            subtitle: new Text('2018-10-10'),
            trailing: new Column(
              children: <Widget>[
                new Text('5',style: new TextStyle(color: Colors.red,fontSize: 18),),
                new Text('提现成功',style: new TextStyle(color: Color.fromRGBO(150, 150, 150, 1)),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}