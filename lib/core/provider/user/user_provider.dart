import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pharma/core/provider/user/user_response.dart';
import '../../api/api.dart';
import '../../api/api__endpoints.dart';
import '../../business/models/user.dart';
import '../app_providers/app_provider.dart';

class UserProvider extends AppProvider {
  // Future<UserResponse> getCreditCards() async {
  //   final response = await api.request(
  //     route: Uri.https(ApiEndpoints.baseUrl),
  //     method: Method.get,
  //     needToken: true,
  //     params: {},
  //   );

  //   return UserResponse(
  //     isSuccess: response.isSuccess,
  //     statusCode: response.statusCode,
  //     response: response.response,
  //     error: response.isSuccess ? null : response.error,
  //   );
  // }

  // Future<ApiResponse> secure3Ds(
  //     {required String transactionId, required String paRes}) async {
  //   final response = await api.request(
  //     route: Uri.https(ApiEndpoints.baseUrl),
  //     method: Method.post,
  //     needToken: true,
  //     params: {'MD': transactionId, 'PaRes': paRes},
  //   );

  //   return response;
  // }

  Future<UserResponse> getUserData() async {
    final response = await api.request(
      route: Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getUser),
      method: Method.get,
      needToken: true,
      params: {},
    );

    return UserResponse(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      response: response.response,
      user: response.isSuccess
          ? await compute(_parseUser, response.response?.bodyBytes)
          : null,
      error: response.isSuccess ? null : response.error,
    );
  }

  // User? _parseUser(Uint8List? bodyBytes) {
  //   if (bodyBytes?.isEmpty ?? true) return null;
  //   try {
  //     final rawJson =
  //         jsonDecode(utf8.decode(bodyBytes!)) as Map<String, dynamic>;
  //     return User.fromMap(rawJson);
  //   } catch (e) {
  //     debugPrint('Unable to parse use: $e');
  //     return null;
  //   }
  // }
  User? _parseUser(Uint8List? bodyBytes) {
    if (bodyBytes?.isEmpty ?? true) return null;
    try {
      User? user;
      final rawJson = jsonDecode(utf8.decode(bodyBytes!));
      user = User.fromMap(rawJson['user']);
      return user;
    } catch (e) {
      debugPrint('Unable to parse user: $e');
      return null;
    }
  }

  Future<UserResponse> logout() async {
    await storage.resetStorage();
    return UserResponse(isSuccess: true);
  }

  // Future<UserResponse> uploadPhoto(File image) async {
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     "Authorization": "Bearer ${await storage.getToken()}",
  //   };

  //   final request = http.MultipartRequest('POST', Uri.https(ApiEndpoints.host, ApiEndpoints.imageUpdate));
  //   request.files.add(await http.MultipartFile.fromPath('image', image.path));

  //   request.headers.addAll(headers);

  //   final response = await http.Response.fromStream(await request.send());
  //   Api.logResponse(response);

  //   if (response.statusCode >= 200 && response.statusCode <= 299) {
  //     return UserResponse(isSuccess: true, user: _parseUser(response.bodyBytes));
  //   }
  //   return UserResponse(isSuccess: false);
  // }

}
