class CustomApiException implements Exception {
  String? message;
  int? statusCode;

  CustomApiException(this.message, {this.statusCode});

  @override
  String toString() {
    return message.toString();
  }
}
