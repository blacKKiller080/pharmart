import 'package:http/http.dart';
import 'package:pharma/core/business/models/category_dto.dart';

import '../../api/api_response.dart';
import '../../business/models/user.dart';

class AuthorizationResponse extends ApiResponse {
  final User? user;
  final List<CategoryDto>? category_dto;
  const AuthorizationResponse(
      {this.user,
      this.category_dto,
      bool isSuccess = false,
      int? statusCode,
      Response? response,
      String? error})
      : super(
          isSuccess: isSuccess,
          statusCode: statusCode,
          response: response,
          error: error,
        );
}
