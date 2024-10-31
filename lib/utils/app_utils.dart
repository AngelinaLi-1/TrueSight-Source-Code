import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:realorfake/ui/widgets/widgets.dart';

void showToast(String? message,
    {bool isSuccess = false, ToastGravity? gravity}) {
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor:
          isSuccess ? AppColors.instance.green : AppColors.instance.red,
      gravity: gravity,
      textColor: Colors.white,
      fontSize: 16.0);
}

String getCurrentDate(String? format) {
  DateTime dateTime = DateTime.now();
  String date = DateFormat(format ?? 'dd-MM-yyyy').format(dateTime);
  return date;
}

String formatDate(DateTime? date, {String? format}) {
  if (date == null) {
    return "";
  }
  return DateFormat(format ?? 'd MMM').format(date);
}

Future<String> getUniqueDeviceId() async {
  String uniqueDeviceId = '';
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    uniqueDeviceId =
        '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}';
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    uniqueDeviceId = '${androidDeviceInfo.display}:${androidDeviceInfo.id}';
  }
  return uniqueDeviceId;
}

String convertSecondToMin(dynamic timeInSecond) {
  int seconds = 0;
  if (timeInSecond == null) {
    return "NA";
  }
  if (timeInSecond is String) {
    try {
      seconds = int.parse(timeInSecond);
    } catch (e) {
      seconds = 0;
    }
  }
  if (timeInSecond is int) {
    seconds = timeInSecond;
  }
  if (seconds == 0) {
    return "NA";
  }
  int minutes = (seconds / 60).truncate();
  if (minutes == 0) {
    return "${seconds}s";
  }
  return (minutes % 60).toString().padLeft(2, '0');
}

String convertSecondToMin1(dynamic timeInSecond) {
  int seconds = 0;
  if (timeInSecond == null) {
    return "NA";
  }
  if (timeInSecond is String) {
    try {
      seconds = int.parse(timeInSecond);
    } catch (e) {
      seconds = 0;
    }
  }
  if (timeInSecond is int) {
    seconds = timeInSecond;
  }
  if (seconds == 0) {
    return "NA";
  }
  int minutes = (seconds / 60).truncate();
  if (minutes == 0) {
    return "${seconds}s";
  }
  if ((seconds % 60) > 0) {
    return "${(minutes % 60).toString().padLeft(2, '0')}m ${(seconds % 60).toString().padLeft(2, '0')}s";
  }
  return "${(minutes % 60).toString().padLeft(2, '0')}m";
}
