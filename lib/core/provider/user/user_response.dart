import '../../api/api_response.dart';
import '../../business/models/user.dart';

class UserResponse extends ApiResponse {
  final User? user;

  const UserResponse(
      {this.user,
      super.isSuccess,
      super.statusCode,
      super.response,
      super.error});
}
