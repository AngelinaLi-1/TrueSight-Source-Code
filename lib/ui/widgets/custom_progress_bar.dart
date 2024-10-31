import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:realorfake/ui/widgets/widgets.dart';

class CustomProgressBar {
  CustomProgressBar();
  static bool isDialogShowing = false;
  static late BuildContext dialogContext;
  static void show(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      isDialogShowing = true;
      Container alert = Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Platform.isIOS
                ? CupertinoActivityIndicator(color: AppColors.instance.white)
                : CircularProgressIndicator(color: AppColors.instance.white),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) {
                  return;
                }
              },
              child: alert);
        },
      );
    }
  }

  static void hide() {
    if (isDialogShowing) {
      isDialogShowing = false;
      Navigator.pop(dialogContext);
    }
  }
}
