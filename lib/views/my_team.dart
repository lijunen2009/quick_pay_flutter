import 'package:flutter/material.dart';
import 'package:quick_pay/util/Common.dart';
import 'package:quick_pay/util/ToastUtil.dart';
import 'package:quick_pay/service/user.dart';
import 'package:intl/intl.dart';
import 'package:quick_pay/views/components/no_data.dart';
class MyTeamPage extends StatefulWidget {
  @override
  MyTeamState createState() => MyTeamState();
}

class MyTeamState extends State {
  Map token;
  List list = [];

  _init() async {
    await Common.checkLogin(context);
    token = await Common.getToken();
    _listRecommendUser();
  }

  _listRecommendUser() async {
    Common.showLoading(context);
    Map result = await listRecommendUser(token['id']);
    Common.closeLoading(context);
    if (result['status'] == 200) {
      setState(() {
        list = result['result']['list'];
      });
    } else {
      ToastUtil.showCenterShortToast(result['msg']);
    }
  }

  Widget _buildItem(item) {
    var createTime = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(item['create_time']) * 1000 + 8*3600*1000);
    var formatter = new DateFormat('yyyy-MM-dd');
    return ListTile(
      title: new Text(item['real_name'] != null ? '${item['real_name']}' : ''),
      subtitle: new Text('${item['account']}'),
      trailing: new Text('${formatter.format(createTime)}'),
    );
  }

  @override
  initState() {
    super.initState();
    _init();
  }

  _body(){
    if(list.length == 0){
      return new NoDataPage();
    }else{
      return new ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return new Column(
            children: <Widget>[_buildItem(list[index]), new Divider()],
          );
        },
      );
    }
  }

  Widget build(BuildContext contexy) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('我的推荐'),
          centerTitle: true,
        ),
        body:_body()
    );
  }
}
