import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Color? color;
  const CustomLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(color: color ?? AppColors.instance.white)
          : CircularProgressIndicator(color: color ?? AppColors.instance.white),
    );
  }
}
