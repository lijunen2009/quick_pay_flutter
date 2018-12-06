import 'package:flutter/material.dart';
import 'package:quick_pay/util/MyIcon.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/service/user.dart';
import 'package:common_utils/common_utils.dart';
class PasswordPage extends StatefulWidget {
  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<PasswordPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController accountController = new TextEditingController();
  String _account;
  String _code;
  String _password;
  int timer = 60;
  String codeButtonText = '发送验证码';
  @override
  initState(){
    super.initState();
    Common.checkNetwork();

  }

  _sendSmsCode() async{
    if(accountController.text == null || accountController.text.isEmpty){
      ToastUtil.showCenterShortToast('请输入手机号');
      return;
    }
    Common.showLoading(context);
    Map result = await sendSmsCode(accountController.text);
    Common.closeLoading(context);
    if(result['status'] == 200){
      ToastUtil.showCenterShortToast(result['msg'].toString());
      _timeCountDown();
    }else{
      ToastUtil.showCenterShortToast(result['msg'].toString());
    }
  }
  _forgetPassword() async{
    Common.showLoading(context);
    Map result = await forgetPassword(_account,_code,_password);
    if(result['status'] == 200){
      ToastUtil.showCenterShortToast(result['msg'].toString());
      new Future.delayed(new Duration(seconds: 2),(){
        Navigator.pushNamedAndRemoveUntil(context, "login", (route) => route == null);
      });

    }else{
      Common.closeLoading(context);
      ToastUtil.showCenterShortToast(result['msg'].toString());
    }
  }
  _timeCountDown(){
    TimerUtil timerCountDown;
    //倒计时test
    if(timer == 60){
      timerCountDown = new TimerUtil(mInterval: 1000, mTotalTime: 59 * 1000);
      timerCountDown.setOnTimerTickCallback((int value) {
        timer--;
        if(mounted) {
          setState(() {
            codeButtonText = timer.toString() + '秒后发送';
          });
        }
        if(timer == 1){
          timer = 60;
          if(mounted) {
            setState(() {
              codeButtonText = '发送验证码';
            });
          }
        }
      });
      timerCountDown.startCountDown();
    }
  }


  _onSubmit(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      _forgetPassword();
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
          controller: accountController,
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
                  if(timer == 60){
                    _sendSmsCode();
                  }
                },
                child: new Text(codeButtonText),
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
        title: new Text('忘记密码'),
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
