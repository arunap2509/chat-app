import 'dart:convert';

import 'package:chat_like_app/models/api_response.dart';
import 'package:chat_like_app/models/register_request.dart';
import 'package:chat_like_app/models/register_response.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://localhost:5292/api/";

  Future<ApiResponse<RegisterResponse>> register(
      RegisterRequest request) async {
    var url = Uri.parse("${baseUrl}auth/register/");
    try {
      var encoded = jsonEncode(request);
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: encoded,
      );

      var responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        var model = RegisterResponse.fromMap(responseData);
        return ApiResponse(success: true, data: model, errors: []);
      }

      var errors = responseData['error'] as List<dynamic>;
      return ApiResponse(success: false, errors: List<String>.from(errors));
    } catch (e) {
      return ApiResponse(success: false, errors: ['Something went wrong$e']);
    }
  }
}
