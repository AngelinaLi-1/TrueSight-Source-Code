import 'package:flutter/material.dart';

class AppColors {
  static final AppColors instance = AppColors._internal();

  factory AppColors() {
    return instance;
  }
  AppColors._internal();

  Color appColor = const Color(0xFF120723);
  Color appColorBottom = const Color(0xFF50247E);
  Color black = const Color(0xFF222222);
  Color lightGray = const Color(0xFF9B9B9B);
  Color red = const Color(0xFFDB3022);
  Color green = Colors.green;
  Color blue = Colors.blue;
  Color yellow = const Color(0xFFffc107);
  Color background = const Color(0xFFFFFFFF);
  Color white = const Color(0xFFFFFFFF);
  Color textColor = const Color(0xFF282828);
  Color textColor1 = const Color(0xFF282828);
  Color textColor2 = const Color(0xFFFFD6DD);
  Color borderColor2 = const Color(0xFF282828);
  Color borderColor3 = const Color(0xFF282828);
  Color textEditBack = const Color(0xFF282828);
  Color darkGray = const Color(0xFF282828);
  Color transparent = const Color(0x00000000);
  Color hintColor = const Color(0xFF282828);
  Color buttonColor = const Color(0xFFE5DCF1);
  Color buttonColor1 = const Color(0xFFFF9051);
  Color lightGrayUpload = const Color(0xFFFAFAFA);
  Color dividerColor = const Color(0xFFF4F2F2);
}
