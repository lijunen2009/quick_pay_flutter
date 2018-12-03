import 'package:flutter/material.dart';
import 'package:quick_pay/service/user.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/views/components/no_data.dart';
class MyCardPage extends StatefulWidget{
  MyCardState createState()=>MyCardState();
}
class MyCardState extends State{
  Map token;
  Map cardInfo;
  @override
  _init() async{
    await Common.checkLogin(context);
    token = await Common.getToken();
    _listBankCard();

  }

  _listBankCard() async{
    Common.showLoading(context);
    Map result =  await listBankCard(token['id']);
    if(result['status'] == 200){
      Common.closeLoading(context);
      setState(() {
        if(result['result']['list'].length > 0){
          cardInfo = result['result']['list'][0];
        }else{
          cardInfo = null;
        }
      });
    }else{
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  initState(){
    super.initState();
    _init();
  }
  _body(){
    if(cardInfo != null && cardInfo['card_number'] != null){
      return new Container(
        width: double.infinity,
        height: 100,
        decoration: new BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: Color.fromRGBO(71, 116, 208, 0.95)),
        margin: new EdgeInsets.all(15.0),
        padding:new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Text(cardInfo != null ? '${cardInfo['bank_name']}' : '',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
            ),
            new Container(
              margin: new EdgeInsets.only(top:10.0),
              child: new Text('储蓄卡',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
            ),
            new Container(
                margin: new EdgeInsets.only(top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(cardInfo != null ?'${cardInfo['card_number']}' : '',style: new TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),textAlign: TextAlign.end,),
                  ],
                )
            ),
          ],
        ),
      );
    }else{
      return new NoDataPage();
    }
  }

  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('我的银行卡'),centerTitle: true,),
      body: _body(),
    );
  }
}