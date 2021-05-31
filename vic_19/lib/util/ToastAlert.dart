import 'package:fluttertoast/fluttertoast.dart';
import 'package:vic_19/PaletteColor.dart';

class ToastAlert{
  static void simpleToast(msg){
    Fluttertoast.showToast(msg: msg,
    textColor: color5,
    backgroundColor: color1,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM);
  }
}