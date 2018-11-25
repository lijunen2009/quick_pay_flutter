import 'package:flutter/material.dart';
import 'package:quick_pay/util/MyIcon.dart';
class WalletPage extends StatefulWidget{
  @override
  WalletState createState()=>WalletState();
}
class WalletState extends State<WalletPage>{
  Widget top = new Container(
    color: Colors.lightBlue[800],
    padding: new EdgeInsets.only(top: 50.0,bottom: 40.0),
    child: new Center(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text('我的余额(元)',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontSize: 15)),
          ),
          new Container(
            padding: new EdgeInsets.only(top: 20.0),
            child: new Text('500',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontSize: 28.0),),
          )
        ],
      ),
    ),
  );
  Widget _body(BuildContext context){
    return new Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: new Column(
        children: <Widget>[
          new ListTile(

            title: new Text('我要提现'),
            leading: new Icon(MyIcon.take_cash,color: Color.fromRGBO(255, 87, 34, 1),),
            trailing: new Icon(Icons.arrow_right),
            onTap: (){
              print('我要提现');
              Navigator.of(context).pushNamed('/cash');
            },
          ),
          new Divider(color: Color.fromRGBO(204, 204, 204, 1),),
          new ListTile(
            title: new Text('提现记录'),
            leading: new Icon(MyIcon.log2,color: Color.fromRGBO(155, 39, 176, 1),),
            trailing: new Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pushNamed('cash_log');
            },
          ),
          new Divider(color: Color.fromRGBO(204, 204, 204, 1),),
          new ListTile(
            title: new Text('钱包明细'),
            leading: new Icon(MyIcon.log,color: Color.fromRGBO(255, 193, 7, 1),),
            trailing: new Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pushNamed('wallet_log');
            },
          ),
          new Divider(color: Color.fromRGBO(204, 204, 204, 1),),
          new ListTile(
            title: new Text('我的银行卡'),
            leading: new Icon(Icons.card_travel,color: Color.fromRGBO(0, 188, 212, 1),),
            trailing: new Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pushNamed('my_card');
            },
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context){
    return new ListView(
      children: <Widget>[
        top,
        _body(context)
      ],
    );
  }
}