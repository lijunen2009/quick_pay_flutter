import 'package:flutter/material.dart';
class MyTeamPage extends StatefulWidget{
  MyTeamState createState()=>MyTeamState();
}
class MyTeamState extends State{
  Widget build(BuildContext contexy){
    return new Scaffold(
      appBar: new AppBar(title: new Text('我的推荐'),centerTitle: true,),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('李俊恩'),
            subtitle: new Text('15598045566'),
            trailing: new Text('2018-10-1'),
          ),
          new Divider(),
          new ListTile(
            title: new Text('李俊恩'),
            subtitle: new Text('15598045566'),
            trailing: new Text('2018-10-1'),
          ),
        ],
      ),
    );
  }
}