import 'package:flutter/material.dart';
class AuthDetailPage extends StatefulWidget{
  AuthDetailState createState()=>AuthDetailState();
}
class AuthDetailState extends State{
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('认证信息'),),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        color: Color.fromRGBO(255, 255, 255, 1),
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text('真实姓名'),
              subtitle: new Text('李俊恩'),
              selected: true,
            ),
            new Divider(),
            new ListTile(
              title: new Text('收款账号'),
              subtitle: new Text('621585854545556565'),
            ),
            new Divider(),
            new ListTile(
              title: new Text('所属银行'),
              subtitle: new Text('招商银行'),
            )
          ],
        ),
      ),
    );
  }
}