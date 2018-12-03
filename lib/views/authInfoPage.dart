import 'package:flutter/material.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/service/user.dart';

class AuthInfoPage extends StatefulWidget {
  AuthInfoState createState() => AuthInfoState();
}

class AuthInfoState extends State<AuthInfoPage> {
  Map token;
  bool isIdAuth = false;
  bool isCardAuth = false;

  _init() async {
    await Common.checkLogin(context);
    token = await Common.getToken();
    _getAuthInfo();
  }

  _getAuthInfo() async {
    Common.showLoading(context);
    Map result = await getAuthInfo(token['id']);
    if (result['status'] == 200) {
      Common.closeLoading(context);
      setState(() {
        isIdAuth = result['result']['is_id_auth'] == 1 ? true : false;
        isCardAuth = result['result']['is_card_auth'] == 1 ? true : false;
      });
    } else {
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  @override
  initState() {
    super.initState();
    _init();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('实名认证'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new GestureDetector(
            child: new Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              margin: new EdgeInsets.all(10.0),
              padding: new EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/identify.png',
                  ),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          '个人信息认证',
                          style: new TextStyle(
                              color: Color.fromRGBO(33, 150, 243, 1),
                              fontSize: 22),
                        ),
                        new Text(
                          isIdAuth ? '(已认证)' : '为认证',
                          style: new TextStyle(
                              color: isIdAuth ? Color.fromRGBO(255, 133, 71, 1) :Color.fromRGBO(244, 67, 54, 1) ,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0),
                    child: new Text('提交个人真实姓名、身份证号'),
                  )
                ],
              ),
            ),
            onTap: () {
              if (isIdAuth) {
                Navigator.of(context).pushNamed('/auth_detail');
              } else {
                Navigator.of(context).pushNamed('/auth_identify');
              }
            },
          ),
          new GestureDetector(
            child: new Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              margin: new EdgeInsets.all(10.0),
              padding: new EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/card.png',
                  ),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          '收款账号认证',
                          style: new TextStyle(
                              color: Color.fromRGBO(33, 150, 243, 1),
                              fontSize: 22),
                        ),
                        new Text(
                          isCardAuth ? '(已认证)' : '为认证',
                          style: new TextStyle(
                              color: isCardAuth ?  Color.fromRGBO(255, 133, 71, 1) : Color.fromRGBO(244, 67, 54, 1) ,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0),
                    child: new Text('提交收款账号详细信息'),
                  )
                ],
              ),
            ),
            onTap: () {
              if (isCardAuth) {
                Navigator.of(context).pushNamed('/auth_detail');
              } else {
                Navigator.of(context).pushNamed('/auth_card');
              }
            },
          )
        ],
      ),
    );
  }
}
