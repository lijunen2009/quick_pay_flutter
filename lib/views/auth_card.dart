import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
class AuthCard extends StatefulWidget{
  @override
  AuthCardState createState()=>AuthCardState();
}

class AuthCardState extends State{
  String _cardNo;
  String _openCity = '请选择开户城市';
  String _bankName = '请选择所属银行';
  GlobalKey<FormState> _fromKey = new GlobalKey<FormState>();
  var PickerData = '''
   [
   ["中国工商银行","招商银行"]
   ]
    ''';

  var city = '''
  [
    ["内蒙古","山西","山东"],
    ["呼和浩特","包头","鄂尔多斯"]
  ]
  ''';
  void _onSubmit(){
    final form = _fromKey.currentState;
    if(form.validate()){
      form.save();
      showDialog(context: context,builder: (r)=>new AlertDialog(content: new Text('$_cardNo'),));
    }
  }
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
          String temp = picker.adapter.text.replaceAll('[', '');
          temp = temp.replaceAll(']', '');
          setState(() {
            _bankName = temp;
          });

        }).showModal(this.context); //
  }
  showCityPicker(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(city), isArray: true),
        changeToFirst: true,
        hideHeader: false,
        confirmText: '确定',
        confirmTextStyle: new TextStyle(color: Colors.blue),
        cancelText: '取消',
        cancelTextStyle: new TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          String temp = picker.adapter.text.replaceAll('[', '');
          temp = temp.replaceAll(']', '');
          List cityList = temp.split(',');
          setState(() {
            _openCity = cityList[0]+''+cityList[1];
          });
        }).showModal(this.context); //
  }

  Widget build(BuildContext context){
    Widget _form = new Form(
      key:_fromKey,
      autovalidate: true,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextFormField(
              decoration: new InputDecoration(
                  hintText: '收款账号',
                  labelText: '请输入收款账号',
                  border: OutlineInputBorder()
              ),
              maxLength: 25,
              keyboardType: TextInputType.number,
              onSaved: (val)=>this._cardNo = val,
              validator: (val){
                if(val.isEmpty|| val == null){
                  return '请输入收款账号';
                }
              },
            ),
            margin: new EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
          ),
          new Container(
            height: 60.0,
            margin: new EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
            alignment: AlignmentDirectional(0, 0),
            padding: new EdgeInsets.all(10.0),
            decoration: new BoxDecoration(border:Border.all(color: Color.fromRGBO(129, 129, 129, 1),width: 1.0),borderRadius: BorderRadius.all(Radius.circular(3.0))),
            child: new GestureDetector(
              child:new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text('$_bankName',style: new TextStyle(color: Color.fromRGBO(137, 137, 137, 1),fontSize: 15.0,),),
                ],
              ),
              onTap: (){
                showPicker(context);
              },
            ),
          ),
          new Container(
            height: 60.0,
            margin: new EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
            alignment: AlignmentDirectional(0, 0),
            padding: new EdgeInsets.all(10.0),
            decoration: new BoxDecoration(border:Border.all(color: Color.fromRGBO(129, 129, 129, 1),width: 1.0),borderRadius: BorderRadius.all(Radius.circular(3.0))),
            child: new GestureDetector(
              child:new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text('$_openCity',style: new TextStyle(color: Color.fromRGBO(137, 137, 137, 1),fontSize: 15.0,),),
                ],
              ),
              onTap: (){
                showCityPicker(context);
              },
            ),
          )
        ],
      ),
    );
    Widget _button = new Container(
      child: new RaisedButton(
        onPressed: _onSubmit,
        color: Colors.blue,
        child: new Text('确定',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
      ),
      margin: new EdgeInsets.all(15.0),

    );

    return new Scaffold(
      appBar: new AppBar(title: new Text('收款账号认证'),),
      body:  new Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: new ListView(
          children: <Widget>[
            _form,
            _button
          ],
        ),
      ),
    );
  }
}