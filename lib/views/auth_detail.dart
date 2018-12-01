import 'package:flutter/material.dart';
import 'package:quick_pay/service/user.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/util/Common.dart';
class AuthDetailPage extends StatefulWidget{
  AuthDetailState createState()=>AuthDetailState();
}
class AuthDetailState extends State{
  Map token;
  Map userInfo;
  _init() async{
    await Common.checkLogin(context);
    token = await Common.getToken();
    _getUserInfo();

  }

  _getUserInfo() async{
    Common.showLoading(context);
    Map result = await getUserInfo(token['id']);
    Common.closeLoading(context);
    if(result['status'] == 200){
      setState(() {
        userInfo = result['result'];
      });
    }else{
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  @override
  initState(){
    _init();
  }
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('认证信息'),centerTitle: true,),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        color: Color.fromRGBO(255, 255, 255, 1),
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text('真实姓名'),
              subtitle: new Text(userInfo != null ?'${userInfo['real_name']}' : ''),
            ),
            new Divider(),
            new ListTile(
              title: new Text('收款账号'),
              subtitle: new Text(userInfo != null ? '${userInfo['card_number']}':''),
            ),
            new Divider(),
            new ListTile(
              title: new Text('所属银行'),
              subtitle: new Text(userInfo != null ? '${userInfo['bank_name']}' : ''),
            )
          ],
        ),
      ),
    );
  }
}