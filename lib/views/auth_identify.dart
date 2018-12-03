import 'package:flutter/material.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/service/user.dart';

class AuthIdentity extends StatefulWidget {
  AuthIdentityState createState() => AuthIdentityState();
}

class AuthIdentityState extends State<AuthIdentity> {
  String _name;
  String _identify;
  Map token;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() async{
    await Common.checkLogin(context);
    token = await Common.getToken();
  }

  _realNameAuth() async{
    Common.showLoading(context);
    Map result = await realNameAuth(token['id'],_name,_identify);
    if(result['status'] == 200){
      ToastUtil.showCenterShortToast(result['msg']);
      new Future.delayed(new Duration(seconds: 2),(){
        Common.closeLoading(context);
        Navigator.of(context).pushReplacementNamed('/auth_info');
      });

    }else{
      Common.closeLoading(context);
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      showDialog(
//          context: context,
//          builder: (ctx) => new AlertDialog(
//                content: new Text('$_name $_identify'),
//              ));
      _realNameAuth();
    }
  }

  Widget build(BuildContext context) {
    Widget _form = new Form(
      autovalidate: true,
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextFormField(
              decoration: InputDecoration(
                  labelText: '请输入真实姓名',
                  hintText: '姓名',
                  border: OutlineInputBorder()),
//              keyboardType: TextInputType.text,
              onSaved: (val) => this._name = val,
              maxLength: 10,
              initialValue: '李俊恩',
              validator: (v) => (v == null || v.isEmpty) ? '请输入真实姓名' : null,
            ),
            margin: new EdgeInsets.all(10.0),
          ),
          new Container(
            margin: new EdgeInsets.all(10.0),
            child: new TextFormField(
              onSaved: (val) => this._identify = val,
              validator: (v) => (v == null || v.isEmpty) ? '请输入身份证号' : null,
//              keyboardType: TextInputType.text,
              maxLength: 18,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                hintText: '身份证',
                labelText: '请输入身份证号码',
              ),
            ),
          ),

        ],
      ),
    );
    Widget _body = new ListView(
      children: <Widget>[
        _form,
        new Container(
          padding: new EdgeInsets.all(15.0),
          child: new RaisedButton(
            onPressed: _onSubmit,
            textColor: Color.fromRGBO(255, 255, 255, 1),
            color: Colors.lightBlue,
            child: new Text('确定'),
          ),
        )
      ],
    );
    return new Scaffold(
      appBar: new AppBar(title: new Text('身份认证'),centerTitle: true,),
      body: _body,
    );
  }
}
