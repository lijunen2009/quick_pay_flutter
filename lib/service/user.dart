import 'package:quick_pay/util/HttpUtil.dart';

Future login(String account, String password) async {
  String url = 'user/login';
  var data = {'account': account, 'password': password};
  return await HttpUtil().post(url, data: data);
}

Future countUserBalance(userId) async {
  String url = 'user/countUserBalance';
  Map data = {'user_id': userId};
  return await HttpUtil().post(url, data: data);
}

Future getAuthInfo(userId) async {
  String url = 'user/getAuthInfo';
  Map data = {'user_id': userId};
  return await HttpUtil().post(url, data: data);
}

Future getUserInfo(userId) async {
  Map data = {'user_id': userId};
  return await HttpUtil().post('user/getUserInfo', data: data);
}

Future listRecommendUser(userId) async {
  Map data = {'user_id': userId};
  return await HttpUtil().post('user/listRecommendUser', data: data);
}

Future listBankCard(userId) async {
  Map data = {'user_id': userId};
  return await HttpUtil().post('user/listBankCard', data: data);
}

Future listBalanceLog(userId, currPage, pageNumber) async {
  Map data = {
    'user_id': userId,
    'curr_page': currPage,
    'page_number': pageNumber
  };
  return await HttpUtil().post('user/listBalanceLog', data: data);
}

Future listWithdrawLog(userId, currPage, pageNumber) async {
  Map data = {
    'user_id': userId,
    'curr_page': currPage,
    'page_number': pageNumber
  };
  return await HttpUtil().post('withDraw/listWithdrawLog', data: data);
}

Future withDraw(userId,money) async{
  Map data = {
    'user_id':userId,
    'money':money
  };
  return await HttpUtil().post('withDraw/withDraw',data: data);
}

Future realNameAuth(userId,realName,identifyNumber) async{
  Map data = {
    'user_id' :userId,
    'real_name':realName,
    'identity_number':identifyNumber
  };
  return await HttpUtil().post('user/realNameAuth',data: data);
}

Future listArea({String parentId:''}) async{
  Map data = {};
  if(parentId.isNotEmpty){
    data.addAll({'parent_id':parentId});
  }
  return await HttpUtil().post('user/listArea',data: data);
}

Future listAreaCity() async{
  return await HttpUtil().post('user/listAreaCity');
}

Future listSupportBank() async{
  return await HttpUtil().post('user/listSupportBank');
}
Future bindBankCard(userId,cardNumber,bankName,city) async{
  Map data = {
    'user_id':userId,
    'card_number':cardNumber,
    'bank_name':bankName,
    'city':city
  };
  return  await HttpUtil().post('user/bindBankCard',data: data);
}

Future register(account,code,password,{recommendId:''}) async{
  Map data = {
    'account':account,
    'code':code,
    'password':password,
    'recommend_id':recommendId
  };
  return await HttpUtil().post('user/register',data: data);
}

Future sendSmsCode(mobile) async{
  Map data = {
    'mobile':mobile
  };
  return await HttpUtil().post('user/sendSmsCode',data: data);
}

Future forgetPassword(account,code,password) async{
  Map data = {
    'account':account,
    'code':code,
    'password':password
  };
  return await HttpUtil().post('user/forgetPassword',data: data);
}



