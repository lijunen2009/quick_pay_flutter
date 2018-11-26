import 'package:flutter/material.dart';
import 'package:quick_pay/util/MyIcon.dart';

class RegisterPage extends StatefulWidget {
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _account;
  String _code;
  String _password;
  _onSubmit(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      showDialog(
          context: context,
          builder: (ctx) => new AlertDialog(
            content: new Text('$_account $_password $_code'),
          ));
    }
  }
  Widget _form() {
    return new Form(
      autovalidate: true,
      key: _formKey,
        child: new Column(
      children: <Widget>[
        new TextFormField(
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
              icon: new Icon(MyIcon.account),
              labelText: '手机号',
              hintText: '请输入手机号'),
          onSaved: (val)=>this._account = val,
          validator: (val)=>(val == null || val.isEmpty) ? '请输入手机号' : null,
          maxLength: 11,
        ),
        new Container(
          child: new Row(
            children: <Widget>[
              Expanded(
                  child: new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    icon: new Icon(MyIcon.code),
                    labelText: '验证码',
                    hintText: '请输入验证码'),
                onSaved: (val)=>this._code = val,
                validator: (val)=>(val == null || val.isEmpty) ? '请输入验证码' :  null,
                maxLength: 4,
              )),
              new RaisedButton(
                onPressed: (){

                },
                child: new Text('发送验证码'),
                textColor: Color.fromRGBO(255, 255, 255, 1),
                color: Colors.blue
              )
            ],
          ),
        ),
        new TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: new InputDecoration(
              icon: new Icon(MyIcon.password),
              labelText: '密码',
              hintText: '请输入密码'),
          onSaved: (val)=>this._password = val,
          validator: (val)=>(val== null || val.isEmpty) ? '请输入密码' : null,
        ),
      ],
    ));
  }

  Widget _button() {
    return new Container(
      margin: new EdgeInsets.only(top: 60.0),
      child: new RaisedButton(
        onPressed: () {
          _onSubmit();
        },
        child: new Text(
          '确定',
        ),
        color: Colors.blue[800],
        textColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('注册'),
        centerTitle: true,
      ),
      body: new Container(
        margin: new EdgeInsets.only(top: 30.0),
        padding: new EdgeInsets.all(15.0),
        child: new ListView(
          children: <Widget>[_form(), _button()],
        ),
      ),
    );
  }
}
