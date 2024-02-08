import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pharma/core/business/models/category_dto.dart';
import 'dart:async';
import '../../api/api.dart';
import '../../api/api__endpoints.dart';
import '../../business/models/user.dart';
import '../app_providers/app_provider.dart';
import 'authorization_response.dart';

class AuthorizationProvider extends AppProvider {
  Future<AuthorizationResponse> login(String phone, String password) async {
    final response = await api.request(
      route: Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.login),
      method: Method.post,
      params: {'phone': phone, 'password': password},
    );

    return AuthorizationResponse(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      response: response.response,
      user: response.isSuccess
          ? await compute(_parseUser, response.response?.bodyBytes)
          : null,
      error: response.isSuccess ? null : response.error,
    );
  }

  User? _parseUser(Uint8List? bodyBytes) {
    if (bodyBytes?.isEmpty ?? true) return null;
    try {
      User? user;
      final rawJson = jsonDecode(utf8.decode(bodyBytes!));
      user =
          User.fromMap(rawJson['user']).copyWith(token: rawJson['accessToken']);
      return user;
    } catch (e) {
      debugPrint('Unable to parse user: $e');
      return null;
    }
  }

  Future<AuthorizationResponse> registration(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password,
  ) async {
    final response = await api.request(
      route: Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.register),
      method: Method.post,
      params: {
        "name": firstName,
        "surname": lastName,
        "phone": phone,
        "email": email,
        "password": password,
      },
    );

    return AuthorizationResponse(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      response: response.response,
      user: response.isSuccess
          ? await compute(_parseUser, response.response?.bodyBytes)
          : null,
      error: response.isSuccess ? null : response.error,
    );
  }

  Future<AuthorizationResponse> getCategory(String lang) async {
    final response = await api.request(
      route: Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getAllCategories),
      method: Method.get,
      needToken: false,
      params: {
        "lang": lang,
      },
    );

    return AuthorizationResponse(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      response: response.response,
      category_dto: response.isSuccess
          ? await compute(_parseCategories, response.response!.bodyBytes)
          : null,
      error: response.isSuccess ? null : response.error,
    );
  }

  List<CategoryDto>? _parseCategories(Uint8List? bodyBytes) {
    // if (bodyBytes?.isEmpty ?? true) return null;
    try {
      List<CategoryDto>? category_dto;
      final List rawJson = jsonDecode(utf8.decode(bodyBytes!));
      //  final List result = jsonDecode(response!.body)[''];
      // category_dto = CategoryDto.fromMap(rawJson['']);
      // return category_dto;
      return rawJson.map(((e) => CategoryDto.fromJson(e))).toList();
    } catch (e) {
      debugPrint('Unable to parse category: $e');
      return null;
    }
  }

  // Future<List<CategoryDto>> getCategory() async {
  //   var request = http.Request(
  //       'GET', Uri.parse('https://admin.pharmart.kz/api/categories'));

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     //  final Future<String> result = response.stream.bytesToString();
  //     //  return result;
  //   }
  //   Response responsee = await http
  //       .get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getAllCategories));
  //   if (responsee.statusCode == 200) {
  //     final List result = jsonDecode(responsee.body)[''];
  //     return result.map(((e) => CategoryDto.fromJson(e))).toList();
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  // Future<List<BadHabitsDto>> getBadHabits() async {
  //   Response response = await http
  //       .get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getBadaHabits));
  //   if (response.statusCode == 200) {
  //     final List result = jsonDecode(response.body)['data'];
  //     return result.map(((e) => BadHabitsDto.fromJson(e))).toList();
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  // Future<List<LifeStylesDto>> getLifeStyles() async {
  //   Response response = await http
  //       .get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getLifeStyles));
  //   if (response.statusCode == 200) {
  //     final List result = jsonDecode(response.body)['data'];
  //     return result.map(((e) => LifeStylesDto.fromJson(e))).toList();
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  // Future<List<FAQsDto>> getFAQ() async {
  //   Response response =
  //       await http.get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getFAQs));
  //   if (response.statusCode == 200) {
  //     final List result = jsonDecode(response.body)['data'];
  //     return result.map(((e) => FAQsDto.fromJson(e))).toList();
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  // Future<PrivacyDto> getPrivacyPolicy() async {
  //   Response response = await http
  //       .get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getPrivacyPolicy));
  //   if (response.statusCode == 200) {
  //     final result = PrivacyDto.fromJson(jsonDecode(response.body)['data']);
  //     return result;
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  // getDataFromUrl(PrivacyDto privacyDto) async {
  //   String response =
  //       await http.read(Uri.parse(ApiEndpoints.withoutApi + privacyDto.path!));
  //   return response;
  // }

  // //  Future<PrivacyDto> getPrivacyPolicy() async {
  // //   return PrivacyDto.fromJson(
  // //       await http
  // //       .get(Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getPrivacyPolicy)));

  // // }

}
