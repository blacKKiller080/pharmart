import 'package:http/http.dart';

class ApiResponse {
  final bool isSuccess;
  final int? statusCode;
  final Response? response;
  final String? error;

  const ApiResponse({
    this.isSuccess = false,
    this.statusCode,
    this.response,
    this.error,
  });
}
