import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showLongToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
  }

  static void showColoredToast(String msg, String bgcolor, String textcolor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        bgcolor: bgcolor,
        textcolor: textcolor);
  }

  static void showShortToast(String msg) {
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_SHORT, timeInSecForIos: 1);
  }

  static void showTopShortToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1);
  }

  static void showCenterShortToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1);
  }
}
