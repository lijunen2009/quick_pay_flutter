import 'package:flutter/material.dart';
class AuthCard extends StatefulWidget{
  @override
  AuthCardState createState()=>AuthCardState();
}

class AuthCardState extends State{
  String _cardNo;
  GlobalKey<FormState> _fromKey = new GlobalKey<FormState>();
  void _onSubmit(){
    final form = _fromKey.currentState;
    if(form.validate()){
      form.save();
      showDialog(context: context,builder: (r)=>new AlertDialog(content: new Text('$_cardNo'),));
    }
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
            margin: new EdgeInsets.all(15.0),
          ),
          new Container(
            child: new BottomSheet(onClosing: (){}, builder:null),
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