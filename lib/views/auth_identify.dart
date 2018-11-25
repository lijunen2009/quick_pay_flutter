import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';

class AuthIdentity extends StatefulWidget {
  AuthIdentityState createState() => AuthIdentityState();
}

class AuthIdentityState extends State<AuthIdentity> {
  String _name;
  String _identify;
  String _color;
  String _config;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var PickerData = '''
    [
    [
        1,
        2,
        3,
        4
    ],
    [
        11,
        22,
        33,
        44
    ],
    [
        "aaa",
        "bbb",
        "ccc"
    ]
]
    ''';

  showPicker(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerData), isArray: true),
        changeToFirst: true,
        hideHeader: false,
        confirmText: '确定',
        confirmTextStyle: new TextStyle(color: Colors.blue),
        cancelText: '取消',
        cancelTextStyle: new TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.adapter.text);
        }).showModal(this.context); //
  }

  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      showDialog(
          context: context,
          builder: (ctx) => new AlertDialog(
                content: new Text('$_name $_identify'),
              ));
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
              keyboardType: TextInputType.text,
              onSaved: (val) => this._name = val,
              maxLength: 2,
              validator: (v) => (v == null || v.isEmpty) ? '请输入真实姓名' : null,
            ),
            margin: new EdgeInsets.all(10.0),
          ),
          new Container(
            margin: new EdgeInsets.all(10.0),
            child: new TextFormField(
              onSaved: (val) => this._identify = val,
              validator: (v) => (v == null || v.isEmpty) ? '请输入身份证号' : null,
              keyboardType: TextInputType.text,
              maxLength: 20,
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
