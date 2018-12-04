import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
import 'package:quick_pay/service/user.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/util/Common.dart';
class AuthCard extends StatefulWidget{
  @override
  AuthCardState createState()=>AuthCardState();
}

class AuthCardState extends State{
  String _cardNo;
  String _openCity = '请选择开户城市';
  String _bankName = '请选择所属银行';
  Map token;
  List bankList = [];
  List cityList = [];
  List provinceList = [];
  List areaCity = [];
  String pickerData = '''
[
    {
        "a": [
            {
                "a1": [
                    1,
                    2,
                    3,
                    4
                ]
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88
                ]
            },
            {
                "b3": [
                    99,
                    1010,
                    1111,
                    1212
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            }
        ]
    }
]
    ''';
  GlobalKey<FormState> _fromKey = new GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() async{
    await Common.checkLogin(context);
    token = await Common.getToken();
    _listSupportBank();
    new Future.delayed(new Duration(milliseconds: 500),(){
        _listAreaCity();
    });
//   new Future.delayed(new Duration(milliseconds: 500),(){
//     _listArea();
//   });

  }

  _listSupportBank() async{
    Common.showLoading(context);
    Map result = await listSupportBank();
    List tempList = [];
    Common.closeLoading(context);

    if(result['status'] == 200){
      for(var item in result['result']){
        tempList.add(item['bank_name']);
      }
      bankList.add(tempList);
      setState(() {
        bankList = bankList;
      });
    }else{
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  _listArea({parentId:'0',Picker picker}) async{
    Common.showLoading(context);
    Map result = await listArea(parentId: parentId);
    print(result);
    Common.closeLoading(context);
    if(result['status'] == 200){
      for(var item in result['result']){
        var city = _buildCity(item['id']);
        print(city);
        Map pro ={
         item['name']:city
        };
        cityList.add(pro);
      }
      print(cityList);
    }else{
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  _listAreaCity() async{
    Common.showLoading(context);
    Map result = await listAreaCity();
    print(result);
    Common.closeLoading(context);
    if(result['status'] == 200){
      areaCity = result['result'];
    }
  }

  _buildCity(id){
    List city = [];
    for(var item in areaCity){
      if(item['parent_id'] == id){
        city.add(item['name']);
      }
    }
    return city;
  }


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
            pickerdata: bankList, isArray: true),
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
    Picker picker = new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: cityList, isArray:false),
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
        }); //
    picker.showModal(context);


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
      appBar: new AppBar(title: new Text('收款账号认证'),centerTitle: true,),
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