import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/service/user.dart';
import 'package:intl/intl.dart';
import 'package:quick_pay/views/components/no_data.dart';
class WalletLogPage extends StatefulWidget {
  @override
  WalletLogState createState() => WalletLogState();
}

class WalletLogState extends State {
  Map token;
  List list = [];
  int _currPage = 1;
  int _pageNumber = 10;
  int _itemCount = 0;

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        _currPage++;
        _listBalanceLog();
      });
    });
  }

  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        list = [];
        _itemCount = list.length;
        _currPage = 1;
        _listBalanceLog();
      });
    });
  }

  _init() async {
    await Common.checkLogin(context);
    token = await Common.getToken();
    _listBalanceLog();
  }

  _listBalanceLog() async {
    Common.showLoading(context);
    Map result = await listBalanceLog(token['id'], _currPage, _pageNumber);
    Common.closeLoading(context);
    if (result['status'] == 200) {
      for (var value in result['result']['list']) {
        list.add(value);
      }
      if (_currPage == 1) {
        _itemCount = result['result']['list'].length;
      } else {
        _itemCount += result['result']['list'].length;
      }
      setState(() {
        list = list;
        _itemCount = _itemCount;
      });
    } else {
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  @override
  initState() {
    super.initState();
    var networkState = Common.checkNetwork();
    if(networkState != 'no_network'){
      _init();
    }
  }

  Widget _buildMoney(String money, type) {
    if (type == '2') {
      return new Text('+'+money,
          style: new TextStyle(color: Color.fromRGBO(244, 67, 54, 1)));
    } else {
      return new Text('-'+money,
          style: new TextStyle(color: Color.fromRGBO(52, 111, 6, 1)));
    }
  }

  Widget _buildItem(item) {
    DateTime logTime = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(item['create_time']) * 1000 + 8*3600*1000);
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    return new ListTile(
      title: new Text('${item['remark']}'),
      subtitle: new Text('${formatter.format(logTime)}'),
      trailing: _buildMoney(item['money'], item['log_type']),
    );
  }

  Widget _body() {
    if(list.length == 0){
      return new NoDataPage();
    }else{
      return new SafeArea(
        child: new Refresh(
          onFooterRefresh: onFooterRefresh,
          onHeaderRefresh: onHeaderRefresh,
          childBuilder: (BuildContext context,
              {ScrollController controller, ScrollPhysics physics}) {
            return ListView.builder(
                physics: physics,
                controller: controller,
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  return new Column(
                    children: <Widget>[_buildItem(list[index]), new Divider()],
                  );
                });
          },
        ),
      );
    }

  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('钱包明细'),
          centerTitle: true,
        ),
        body: _body());
  }
}
