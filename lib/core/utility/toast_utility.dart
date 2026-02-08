import 'package:fluttertoast/fluttertoast.dart';

class ToastUtility {

  static void show({required String msg}) {
    Fluttertoast.showToast(msg: msg);
  }
}
