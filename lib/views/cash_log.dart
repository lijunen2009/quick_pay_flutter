import 'package:flutter/material.dart';
import 'package:quick_pay/service/user.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:intl/intl.dart';
import 'package:quick_pay/views/components/no_data.dart';
class CashLogPage extends StatefulWidget {
  @override
  CashLogState createState() => CashLogState();
}

class CashLogState extends State {
  Map token;
  List list = [];
  int _currPage = 1;
  int _pageNumber = 10;
  int _itemCount = 0;

  @override
  initState() {
    super.initState();
    _init();
  }

  _init() async {
    await Common.checkLogin(context);
    token = await Common.getToken();
    _listWithdrawLog();
  }

  _listWithdrawLog() async {
    Common.showLoading(context);

    Map result = await listWithdrawLog(token['id'], _currPage, _pageNumber);
    Common.closeLoading(context);
    if (result['status'] == 200) {
      for (var item in result['result']['list']) {
        list.add(item);
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

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        _currPage++;
        _listWithdrawLog();
      });
    });
  }

  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        list = [];
        _itemCount = list.length;
        _currPage = 1;
        _listWithdrawLog();
      });
    });
  }
  _itemBuilder(item){
    DateTime applyTime = DateTime.fromMillisecondsSinceEpoch(int.parse(item['apply_time']) *1000 + 8 * 3600 *1000);
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text('${item['order_no']}'),
          subtitle: new Text('${formatter.format(applyTime)}'),
          trailing: new Column(
            children: <Widget>[
              new Text(
                '${item['money']}',
                style: new TextStyle(color: Colors.red, fontSize: 18),
              ),
              new Text(
                item['status'] == '2' ? '提现成功' : '处理中',
                style: new TextStyle(color: Color.fromRGBO(150, 150, 150, 1)),
              )
            ],
          ),
        ),
        new Divider()
      ],
    );
  }
  Widget _body() {
    if(list.length == 0){
      return new NoDataPage();
    }else{
      return new SafeArea(
          child: new Refresh(
            onHeaderRefresh: onHeaderRefresh,
            onFooterRefresh: onFooterRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics physics}) {
              return new ListView.builder(
                  controller: controller,
                  physics: physics,
                  itemCount: _itemCount,
                  itemBuilder: (context,index){
                    return _itemBuilder(list[index]);
                  }
              );
            },
          ));
    }

  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('提现记录'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }
}
