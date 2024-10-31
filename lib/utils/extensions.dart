import 'package:realorfake/ui/widgets/custom_dialog.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

extension Navigation on BuildContext {
  pop({dynamic values}) => Navigator.of(this).pop(values);

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) async {
    dynamic value1;
    await Navigator.of(this)
        .pushNamed(routeName, arguments: arguments)
        .then((value) {
      value1 = value;
    });
    return value1;
  }

  pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName,
      {Object? arguments}) async {
    dynamic value1;
    await Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments)
        .then((value) {
      value1 = value;
    });
    return value1;
  }

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  void showSnackbar(String? message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text("$message"),
        backgroundColor:
            isSuccess ? AppColors.instance.green : AppColors.instance.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future showAlertDialog({
    String? message,
    String? title,
    String? cancelButtonText,
    Function? cancelButtonCallback,
    Function? okButtonCallback,
    String? imageSuccess,
    TextAlign? textAlign,
    String? okButtonText,
    bool? isShowSuccessImage,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.instance.white,
          surfaceTintColor: AppColors.instance.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          content: CustomDialog(
            message: message,
            title: title,
            cancelButtonCallback: cancelButtonCallback,
            okButtonCallback: okButtonCallback,
            cancelButtonText: cancelButtonText,
            textAlign: textAlign,
            imageSuccess: imageSuccess,
            okButtonText: okButtonText,
            isShowSuccessImage: isShowSuccessImage,
          ),
        );
      },
    );
  }
}
