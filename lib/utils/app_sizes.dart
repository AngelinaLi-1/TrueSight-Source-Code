import 'package:flutter/material.dart';

class AppSizes {
  static final AppSizes instance = AppSizes._internal();

  factory AppSizes() {
    return instance;
  }
  AppSizes._internal();

  static double logoWidth = 110.0;
  static double logoHeight = 60.0;

  final double rightLeftMargin = 15;
  final double topBottomMargin = 15;
  final double margin5 = 5.0;
  final double margin10 = 10.0;
  final double margin15 = 15.0;
  final double margin20 = 20.0;
  final double margin25 = 25.0;
  final double buttonRadius = 10.0;
  final double textFieldRadius = 4.0;

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
