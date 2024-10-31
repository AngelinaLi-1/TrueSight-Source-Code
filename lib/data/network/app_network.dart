import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:realorfake/ui/widgets/widgets.dart';

class AppNetworkUtils {
  static final AppNetworkUtils instance = AppNetworkUtils.internal();
  AppNetworkUtils.internal();
  factory AppNetworkUtils() => instance;

  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> get(
      {String? endPointUrl,
      String? customBaseUrl,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    final String baseUrl = customBaseUrl ?? AppStrings.baseUrl;
    final String url = endPointUrl != null ? '$baseUrl$endPointUrl' : baseUrl;

    final String queryString = body?.entries.map((entry) {
          return '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}';
        }).join('&') ??
        '';

    final String requestUrl =
        queryString.isNotEmpty ? '$url?$queryString' : url;

    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'deviceType': Platform.isAndroid
          ? 'android'
          : Platform.isIOS
              ? 'ios'
              : 'web',
      'Authorization': "Bearer ${AppStrings.token}",
    };

    final mergedHeaders =
        headers != null ? {...defaultHeaders, ...headers} : defaultHeaders;

    safePrint("Request URL : $requestUrl Requested Header : $mergedHeaders");

    final response =
        await http.get(Uri.parse(requestUrl), headers: mergedHeaders);

    safePrint("Response : ${response.statusCode}, ${response.body}");

    final jsonResponse = json.decode(response.body);
    final String message = jsonResponse['message'] ?? '';

    if (response.statusCode == 200) {
      return _decoder.convert(response.body);
    } else {
      throw CustomApiException(
          message.isNotEmpty ? message : AppStrings.errorMessage,
          statusCode: response.statusCode);
    }
  }

  Future<dynamic> post({
    String? endPointUrl,
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
  }) async {
    final String url = endPointUrl != null
        ? '${AppStrings.baseUrl}$endPointUrl'
        : AppStrings.baseUrl;

    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'deviceType': Platform.isAndroid
          ? 'android'
          : Platform.isIOS
              ? 'ios'
              : 'web',
      'Authorization': "Bearer ${AppStrings.token}",
    };

    final mergedHeaders =
        headers != null ? {...defaultHeaders, ...headers} : defaultHeaders;

    final String data = json.encode(body);
    safePrint("Request URL : $url , Request Data : $data");

    final response = await http.post(
      Uri.parse(url),
      body: data,
      headers: mergedHeaders,
      encoding: encoding,
    );

    safePrint("Response : ${response.statusCode}, ${response.body}");

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final String message = jsonResponse['message'] ?? '';

    if (response.statusCode == 200) {
      return _decoder.convert(response.body);
    } else {
      throw CustomApiException(
        message.isNotEmpty ? message : AppStrings.errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  // Future<dynamic> patch(
  //     {String? endPointUrl, Map<String, String>? headers, body, encoding}) {
  //   var headerss = {
  //     'Content-Type': 'application/json',
  //     "deviceType": Platform.isAndroid
  //         ? "android"
  //         : Platform.isIOS
  //             ? "ios"
  //             : "web",
  //     "Authorization": AppStrings.token,
  //   };
  //   if (headers != null) {
  //     headerss = headers;
  //   }
  //   var url = AppStrings.baseUrl;
  //   if (endPointUrl != null) {
  //     url = "$url$endPointUrl";
  //   }
  //   var data = json.encode(body);
  //   safePrint("Request URL : $url , Request Data : $data");
  //   return http
  //       .patch(Uri.parse(url),
  //           body: data, headers: headerss, encoding: encoding)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //     safePrint("Response : $statusCode, $res");
  //     final Map<String, dynamic> jsonResponse = json.decode(res);
  //     String message = jsonResponse['message'];
  //     if (statusCode == 200) {
  //       return _decoder.convert(res);
  //     } else if (statusCode == 401) {
  //       throw CustomApiException(AppStrings.instance.errorMessage401,
  //           statusCode: statusCode);
  //     } else if (statusCode == 404) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode == 500) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode < 200 || statusCode > 400) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     }
  //   });
  // }

  // Future<dynamic> put(
  //     {String? endPointUrl, Map<String, String>? headers, body, encoding}) {
  //   var headerss = {
  //     'Content-Type': 'application/json',
  //     "deviceType": Platform.isAndroid
  //         ? "android"
  //         : Platform.isIOS
  //             ? "ios"
  //             : "web",
  //     "token": AppStrings.token,
  //     "Authorization": "Bearer ${AppStrings.token}",
  //   };
  //   if (headers != null) {
  //     headerss = headers;
  //   }
  //   safePrint("Headers : $headerss");
  //   String url = AppStrings.baseUrl;
  //   if (endPointUrl != null) {
  //     url = "$url$endPointUrl";
  //   }
  //   var data = json.encode(body);
  //   safePrint("Request URL : $url , Request Data : $data");
  //   return http
  //       .put(Uri.parse(url), body: data, headers: headerss, encoding: encoding)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //     safePrint("Response : $statusCode, $res");
  //     final Map<String, dynamic> jsonResponse = json.decode(res);
  //     String message = "Something went wrong";
  //     if (jsonResponse.containsKey("message")) {
  //       message = jsonResponse['message'] ?? "";
  //     }
  //     if (statusCode == 401) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode == 404) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode == 500) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode < 200 || statusCode > 400) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else {
  //       return _decoder.convert(res);
  //     }
  //   });
  // }

  // Future<dynamic> patchGet(
  //     {String? endPointUrl, String? customBaseUrl, body, data, headers}) {
  //   final queryString = body.entries.map((entry) {
  //     return '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}';
  //   }).join('&');
  //   String baseUrl = AppStrings.baseUrl;
  //   if (customBaseUrl != null) {
  //     baseUrl = customBaseUrl;
  //   }
  //   if (endPointUrl != null) {
  //     baseUrl = "$baseUrl$endPointUrl";
  //   }
  //   var url = '$baseUrl';
  //   if (queryString.isNotEmpty) {
  //     url = '$baseUrl?$queryString';
  //   }
  //   var headerss = {
  //     'Content-Type': 'application/json',
  //     "deviceType": Platform.isAndroid
  //         ? "android"
  //         : Platform.isIOS
  //             ? "ios"
  //             : "web",
  //     "Authorization": AppStrings.token,
  //   };
  //   if (headers != null) {
  //     headerss = headers;
  //   }
  //   var data1 = json.encode(data);
  //   safePrint("Request URL : $url , Request Body : $data1");
  //   return http
  //       .patch(Uri.parse(url), body: data1, headers: headerss)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //     safePrint("Response :$statusCode, $res");
  //     final Map<String, dynamic> jsonResponse = json.decode(res);
  //     String message = "Something went wrong";
  //     if (jsonResponse.containsKey("message")) {
  //       message = jsonResponse['message'];
  //     }
  //     if (statusCode == 200) {
  //       return _decoder.convert(res);
  //     } else if (statusCode == 401) {
  //       throw CustomApiException(AppStrings.instance.errorMessage401,
  //           statusCode: statusCode);
  //     } else if (statusCode == 404) {
  //       throw CustomApiException(AppStrings.instance.errorMessage404,
  //           statusCode: statusCode);
  //     } else if (statusCode == 500) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode < 200 || statusCode > 400) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     }
  //   });
  // }

  // Future<dynamic> delete(
  //     {String? endPointUrl, String? customBaseUrl, body, headers}) {
  //   String queryString = Uri(queryParameters: body).query;
  //   String baseUrl = AppStrings.baseUrl;
  //   if (customBaseUrl != null) {
  //     baseUrl = customBaseUrl;
  //   }
  //   if (endPointUrl != null) {
  //     baseUrl = "$baseUrl$endPointUrl";
  //   }
  //   var url = '$baseUrl';
  //   if (queryString.isNotEmpty) {
  //     url = '$baseUrl?$queryString';
  //   }
  //   var headerss = {
  //     'Content-Type': 'application/json',
  //     "deviceType": Platform.isAndroid
  //         ? "android"
  //         : Platform.isIOS
  //             ? "ios"
  //             : "web",
  //     "Authorization": AppStrings.token,
  //   };
  //   if (headers != null) {
  //     headerss = headers;
  //   }
  //   safePrint("Request URL : $url");
  //   return http
  //       .delete(Uri.parse(url), headers: headerss)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //     safePrint("Response :$statusCode, $res");
  //     final Map<String, dynamic> jsonResponse = json.decode(res);
  //     String message = "";
  //     if (jsonResponse.containsKey("message")) {
  //       message = jsonResponse['message'];
  //     }
  //     if (statusCode == 200) {
  //       return _decoder.convert(res);
  //     } else if (statusCode == 401) {
  //       throw CustomApiException(AppStrings.instance.errorMessage401,
  //           statusCode: statusCode);
  //     } else if (statusCode == 404) {
  //       throw CustomApiException(AppStrings.instance.errorMessage404,
  //           statusCode: statusCode);
  //     } else if (statusCode == 500) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else if (statusCode < 200 || statusCode > 400) {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     } else {
  //       throw CustomApiException(message, statusCode: statusCode);
  //     }
  //   });
  // }

  // Future<dynamic> downloadFile(
  //     {String? endPointUrl,
  //     Map<String, String>? headers,
  //     body,
  //     encoding,
  //     String? fileName}) async {
  //   if (Platform.isAndroid) {
  //     final androidInfo = await DeviceInfoPlugin().androidInfo;
  //     PermissionStatus permissionStatus;
  //     if (androidInfo.version.sdkInt <= 32) {
  //       permissionStatus = await Permission.storage.status;
  //     } else {
  //       permissionStatus = await Permission.photos.status;
  //     }

  //     if (!permissionStatus.isGranted) {
  //       if (androidInfo.version.sdkInt <= 32) {
  //         permissionStatus = await Permission.storage.request();
  //       } else {
  //         permissionStatus = await Permission.photos.request();
  //       }
  //       if (!permissionStatus.isGranted) {
  //         downloadFile(
  //             endPointUrl: endPointUrl,
  //             headers: headers,
  //             body: body,
  //             encoding: encoding,
  //             fileName: fileName);
  //         return;
  //       }
  //     }
  //   }
  //   Directory? downloadDir;
  //   if (Platform.isAndroid) {
  //     downloadDir = await getExternalStorageDirectory();
  //   } else {
  //     downloadDir = await getApplicationDocumentsDirectory();
  //   }
  //   var path = "${downloadDir?.path}/$fileName";
  //   var file = File(path);
  //   var headerss = {
  //     'Content-Type': 'application/json',
  //     "deviceType": Platform.isAndroid
  //         ? "android"
  //         : Platform.isIOS
  //             ? "ios"
  //             : "web",
  //     "Authorization": AppStrings.token,
  //   };
  //   if (headers != null) {
  //     headerss = headers;
  //   }
  //   String url = AppStrings.baseUrl;
  //   if (endPointUrl != null) {
  //     url = "$url$endPointUrl";
  //   }
  //   var data = json.encode(body);
  //   safePrint("Request URL : $url , Request Data : $data");
  //   return http
  //       .post(Uri.parse(url), body: data, headers: headerss, encoding: encoding)
  //       .then((http.Response response) {
  //     var res = response.bodyBytes;
  //     final int statusCode = response.statusCode;
  //     safePrint("Response : $statusCode");
  //     if (statusCode == 200) {
  //       file.writeAsBytes(res);
  //       return path;
  //     } else if (statusCode == 401) {
  //       throw CustomApiException(AppStrings.instance.errorMessage401,
  //           statusCode: statusCode);
  //     } else if (statusCode == 404) {
  //       throw CustomApiException(AppStrings.instance.errorMessage404,
  //           statusCode: statusCode);
  //     } else {
  //       throw CustomApiException(AppStrings.instance.errorMessage200,
  //           statusCode: statusCode);
  //     }
  //   });
  // }
}
