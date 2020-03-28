import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';

class DialogCustom{
static void showCustomDialog(BuildContext context, String title, String message, DialogType type) {
AwesomeDialog(context: context,
dialogType: type,
animType: AnimType.BOTTOMSLIDE,
tittle: title,
desc: message,
//btnCancelOnPress: () {},
btnOkOnPress: () {}).show();
}
}