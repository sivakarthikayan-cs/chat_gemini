import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GlobalToast {
  static void showToast(
    String msg, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    Color? customBackgroundColor,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: customBackgroundColor ?? backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
