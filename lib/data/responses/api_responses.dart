class ApiResponse<T extends Serializable> {
  bool isSuccess;
  String message;
  T? data;
  List<T>? dataList;
  ApiResponse({
    required this.isSuccess,
    required this.message,
    this.data,
    this.dataList,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    if (json["data"] is List) {
      return ApiResponse<T>(
        isSuccess: json["isSuccess"],
        message: json["message"],
        dataList: (json["data"] as List)
            .map((item) => create(item as Map<String, dynamic>) as T)
            .toList(),
      );
    } else {
      return ApiResponse<T>(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] != null
            ? json["data"].isEmpty
                ? null
                : create(json["data"])
            : null,
      );
    }
  }
}

abstract class Serializable {}
