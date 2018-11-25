import 'package:flutter/material.dart';
import 'package:quick_pay/util/MyIcon.dart';

class LoginPage extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State {
  String _name = '';
  String _password = '';
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  _onSubmit(){
    final form =  _formkey.currentState;
    if(form.validate()){
      form.save();
      showDialog(
          context: context,
          builder: (ctx) => new AlertDialog(
            content: new Text('$_name $_password'),
          ));
    }
  }
  Widget _body(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Form(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                    icon: new Icon(MyIcon.account),
                    hintText: '请输入账号',
                    labelText: '账号'),
                maxLength: 11,
                keyboardType: TextInputType.number,
                onSaved: (val)=>this._name = val,
                validator: (val)=>(val == null || val.isEmpty) ? '请输入账号' : null,
              ),
              new TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                    icon: new Icon(MyIcon.password),
                    hintText: '请输入密码',
                    labelText: '密码'),
                keyboardType: TextInputType.text,
                onSaved: (val)=>this._password = val,
                validator: (val)=>(val == null || val.isEmpty) ? '请输入密码' :  null,
              )
            ],
          ),
          key: _formkey,
          autovalidate: true,
        ),
        new Container(
          margin: new EdgeInsets.only(top: 40.0),
          child: new RaisedButton(
            onPressed: () {
              _onSubmit();
            },
            child: new Text('确定'),
            color: Colors.blue[800],
            textColor: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 20.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('注册'),
              new Text('忘记密码')
            ],
          ),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('登录'),
          centerTitle: true,
        ),
        body: new Container(
            margin: new EdgeInsets.only(top: 30.0),
            padding: new EdgeInsets.all(15.0),
            color: Color.fromRGBO(255, 255, 255, 1),
            child: _body(context)));
  }
}
