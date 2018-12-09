import 'package:flutter/material.dart';
import 'package:quick_pay/views/indexPage.dart';
import 'package:quick_pay/views/walletPage.dart';
import 'package:quick_pay/views/settingPage.dart';
import 'package:quick_pay/util/MyIcon.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _tabIndex = 0;
  Map token;
  Map balance;
  var _title = ['首页', '钱包', '设置'];

  var _body = [new IndexPage(), new WalletPage(), new SettingPage()];

  _init() async {
    await Common.checkLogin(context);
  }

  _logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(context, "login", (route) => route == null);
  }

  @override
  initState() {
    super.initState();
    var networkState = Common.checkNetwork();
    if(networkState != 'no_network'){
      _init();
    }
  }
  _scan() async{
    Map scsnResult = await Common.scan();
    print(scsnResult);
  }
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(238, 238, 238, 1),
        appBar: new AppBar(
          leading: new GestureDetector(
            child: Icon(MyIcon.scan),
            onTap: (){
              _scan();
//              ToastUtil.showCenterShortToast('建设中');
            },
          ),
          title: new Text(_title[_tabIndex]),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(MyIcon.log_out),
                onPressed: () {
                  _logout();

                })
          ],
        ),
        body: _body[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: const Text('首页')),
            new BottomNavigationBarItem(
                icon: new Icon(MyIcon.wallet), title: const Text('钱包')),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.settings), title: const Text('设置')),
          ],
          //设置显示的模式
          type: BottomNavigationBarType.fixed,
          //设置当前的索引
          currentIndex: _tabIndex,
          //tabBottom的点击监听
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }
}
