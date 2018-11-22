import 'package:flutter/material.dart';
class WalletLogPage extends StatefulWidget{
  @override
  WalletLogState createState()=>WalletLogState();
}
class WalletLogState extends State{
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('钱包明细'),),
      body: ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('机具计划'),
            subtitle: new Text('2018-10-10'),
            trailing: new Text('+160',style: new TextStyle(color: Color.fromRGBO(244, 67, 54, 1)),),
          ),
          new Divider(),
          new ListTile(
            title: new Text('机具计划'),
            subtitle: new Text('2018-10-10'),
            trailing: new Text('+160',style: new TextStyle(color: Color.fromRGBO(244, 67, 54, 1)),),
          ),
        ],
      ),
    );
  }
}