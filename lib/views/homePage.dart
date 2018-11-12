import 'package:flutter/material.dart';
import 'package:quick_pay/views/indexPage.dart';
import 'package:quick_pay/views/walletPage.dart';
class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _tabIndex = 0;
  var _body = [
    new IndexPage(),
    new WalletPage()
    
  ];  

  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: Color.fromRGBO(238, 238, 238, 1),
        appBar: new AppBar(title: new Text('首页')),
        body: _body[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: const Text('首页')),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.monetization_on), title: const Text('钱包')),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.settings), title: const Text('设置')),
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
