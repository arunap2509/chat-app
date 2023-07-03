import 'dart:convert';

import 'package:chat_like_app/cubit/app_store.dart';
import 'package:chat_like_app/models/api_response.dart';
import 'package:chat_like_app/models/login_request.dart';
import 'package:chat_like_app/models/register_request.dart';
import 'package:http/http.dart' as http;

import '../models/auth_response.dart';

class AuthService {
  final String baseUrl = "http://localhost:5292/api/";
  final AppStoreBloc appStoreBloc;

  AuthService({required this.appStoreBloc});

  Future<ApiResponse<AuthResponse>> register(RegisterRequest request) async {
    var url = Uri.parse("${baseUrl}auth/register");
    try {
      var encoded = jsonEncode(request);
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: encoded,
      );
      var responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        var model = AuthResponse.fromMap(responseData);
        appStoreBloc.updateAccessToken(model.accessToken);
        appStoreBloc.updateRefreshToken(model.refreshToken);
        appStoreBloc.updateUserId(model.userId);
        return ApiResponse(success: true, data: model, errors: []);
      }

      return _handleError(responseData);
    } catch (e) {
      return ApiResponse(success: false, errors: ['Something went wrong$e']);
    }
  }

  ApiResponse<AuthResponse> _handleError(Map<String, dynamic> responseData) {
    var errors = responseData['error'] as List<dynamic>;
    return ApiResponse(success: false, errors: List<String>.from(errors));
  }

  Future<ApiResponse<AuthResponse>> login(LoginRequest request) async {
    var url = Uri.parse("${baseUrl}auth/login");

    try {
      var encoded = jsonEncode(request);
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: encoded,
      );
      var responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        var model = AuthResponse.fromMap(responseData);
        appStoreBloc.updateAccessToken(model.accessToken);
        appStoreBloc.updateRefreshToken(model.refreshToken);
        appStoreBloc.updateUserId(model.userId);
        return ApiResponse(success: true, data: model, errors: []);
      }
      return _handleError(responseData);
    } catch (e) {
      return ApiResponse(success: false, errors: ['Something went wrong$e']);
    }
  }

  Future<bool> sendOtp(String email) async {
    var url = Uri.parse("${baseUrl}auth/verify-email");

    try {
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    var url = Uri.parse("${baseUrl}auth/verify-otp");

    try {
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String email, String newPassword) async {
    var url = Uri.parse("${baseUrl}auth/forgot-password");

    try {
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: {'email': email, 'newPassword': newPassword},
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> getAccessToken() async {
    var url = Uri.parse("${baseUrl}auth/token");

    try {
      var response = await http.post(
        url,
        headers: {
          "content-type": "application/json; charset=UTF-8",
          "X-Refresh-Token": appStoreBloc.state.refreshToken
        },
      );

      var responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        var accessToken = responseData['accessToken'] as String;
        appStoreBloc.updateAccessToken(accessToken);
        return accessToken;
      }

      return '';
    } catch (e) {
      return '';
    }
  }
}
