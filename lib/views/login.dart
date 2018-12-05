import 'package:flutter/material.dart';
import 'package:quick_pay/util/MyIcon.dart';
import 'package:quick_pay/service/user.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quick_pay/util/Common.dart';
import 'dart:convert';
class LoginPage extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State {
  String _name = '';
  String _password = '';
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  _onSubmit(BuildContext context) {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      Common.showLoading(context);
      _login(context);
    }
  }

  _login(BuildContext context) async {
    Map result = await login(_name, _password);
    if (result['status'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token',json.encode(result['result']['userinfo']));
      Common.closeLoading(context);
      Navigator.of(context).pushReplacementNamed('/homepage');
    } else {
      ToastUtil.showCenterShortToast(result['msg']);
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
                onSaved: (val) => this._name = val,
                validator: (val) =>
                    (val == null || val.isEmpty) ? '请输入账号' : null,
              ),
              new TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                    icon: new Icon(MyIcon.password),
                    hintText: '请输入密码',
                    labelText: '密码'),
                keyboardType: TextInputType.text,
                onSaved: (val) => this._password = val,
                validator: (val) =>
                    (val == null || val.isEmpty) ? '请输入密码' : null,
              )
            ],
          ),
          key: _formkey,
          autovalidate: true,
        ),
        new Container(
          margin: new EdgeInsets.only(top: 60.0),
          child: new RaisedButton(
            onPressed: () {
              _onSubmit(context);
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
              new GestureDetector(
                child: new Text(
                  '注册',
                  style: new TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('register');
                },
              ),
//              new Text(
//                '忘记密码',
//                style: new TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
//              )
            ],
          ),
        ),

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
            padding: new EdgeInsets.all(15.0),
            color: Color.fromRGBO(255, 255, 255, 1),
            child: _body(context)));
  }
}
