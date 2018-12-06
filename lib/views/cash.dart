import 'package:flutter/material.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/service/user.dart';
import 'package:quick_pay/util/Common.dart';
class CashPage extends StatefulWidget{
  @override
  CashState createState()=>CashState();
}
class CashState extends State<CashPage>{
  //提现金额控制器
  static TextEditingController moneyController = TextEditingController();

  Map token;
  Map balance;
  @override
  initState() {
    super.initState();
    var networkState = Common.checkNetwork();
    if(networkState != 'no_network'){
      _init();
    }
  }
  _init() async {
    await Common.checkLogin(context);
    token = await Common.getToken();
    _countUserBalance();
  }

  _countUserBalance() async {
    Common.showLoading(context);
    Map result = await countUserBalance(token['id']);
    Common.closeLoading(context);
    if (result['status'] == 200) {
      setState(() {
        balance = result['result'];
      });
    } else {
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }
  _withDraw() async{
    Common.showLoading(context);
    Map result = await withDraw(token['id'],moneyController.text);
    print(result);
    Common.closeLoading(context);
    if(result['status'] == 200){
      Common.closeLoading(context);
      Navigator.of(context).pushNamed('cash_success');
    }else{
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }


  Widget _body(){
    return new Column(
      children: <Widget>[
        new Container(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text('可提现金额',style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
                ),
                new Container(
                  margin: new EdgeInsets.only(top: 10.0),
                  child: new Text(balance != null ? '${balance['balance']}' : '0',style: new TextStyle(color: Colors.red,fontSize: 28.0),),
                )
              ],
            ),
          ),
          padding: new EdgeInsets.all(20.0),
          color: Colors.lightBlue[800],
        ),
        new Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          padding: new EdgeInsets.only(left: 15.0,right: 15.0,bottom: 15.0),
          child: new TextField(
            controller: moneyController,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              hintText: '请输入提现金额',
            ),
          ),
        ),
        new Container(
          alignment: AlignmentDirectional.topStart,
          padding: new EdgeInsets.only(left: 15.0,right: 15.0,top: 8.0,bottom: 8.0),
          child: new Text('账户信息',style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),textAlign: TextAlign.left,),
        ),
        new Container(
            padding: new EdgeInsets.all(15.0),
            color: Color.fromRGBO(255, 255, 255, 1),
            alignment: AlignmentDirectional.topStart,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text('账户姓名：'),
                    new Text('李俊恩')
                  ],
                ),
                new Divider(),
                new  Row(
                  children: <Widget>[
                    new Text('收款账号：'),
                    new Text('62148545785525556')
                  ],
                )
              ],
            )
        ),
        new Container(
          alignment: AlignmentDirectional.topStart,
          padding: new EdgeInsets.only(left: 15.0,right: 15.0,top: 8.0,bottom: 8.0),
          child: new Text('温馨提示',style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),textAlign: TextAlign.left,),
        ),
        new Container(
          alignment: AlignmentDirectional.topStart,
          padding: new EdgeInsets.only(top: 10.0,right: 15.0,left:15.0,bottom: 10.0),
          color: Color.fromRGBO(255, 255, 255, 1),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('每笔提现要扣除三元手续费，单笔最大五万。',style: TextStyle(color: Colors.red,fontSize: 12),textAlign: TextAlign.left,),
              new Text('提现到账说明：',style: TextStyle(color: Colors.red,fontSize: 12),textAlign: TextAlign.left),
              new Text('工作日15点之前提现当天到账，15点后提现下个工作日到账；非工作日提现，工作日到账。',style: TextStyle(color: Colors.red,fontSize: 12),textAlign: TextAlign.left),
            ],
          ),
        ),

      ],

    );
  }
  Widget _button(){
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new RaisedButton(
        onPressed: (){
          String value = moneyController.text;
          if(value.isEmpty){
            ToastUtil.showCenterShortToast('请输入提现金额');
            return false;
          }
          if(double.parse(value) > double.parse(balance['balance'])){
            ToastUtil.showCenterShortToast('请输入正确的提现金额');
            return false;
          }
          if(double.parse(value) <5){
            ToastUtil.showCenterShortToast('提现金额不能少于5元');
            return false;
          }
          _withDraw();
        },
        child: new Text('确定'),
        color: Colors.blue,
        textColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('提现'),centerTitle: true,),
      body: new ListView(
//        padding: new EdgeInsets.all(15.0),
//        color: Color.fromRGBO(255, 255, 255, 1),
        children: <Widget>[
          _body(),
          _button()
        ],
      ),
    );
  }
}