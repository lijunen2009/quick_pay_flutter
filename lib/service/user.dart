
import 'package:quick_pay/util/HttpUtil.dart';

Future login(String account,String password) async{
  String url = 'user/login';
  var data = {
    'account':account,
    'password':password
  };
  return await HttpUtil().post(url,data: data);
}