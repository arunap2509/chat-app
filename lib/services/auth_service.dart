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
        await appStoreBloc.updateAccessToken(model.accessToken);
        await appStoreBloc.updateRefreshToken(model.refreshToken);
        await appStoreBloc.updateUserId(model.userId);
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
        await appStoreBloc.updateRefreshToken(model.refreshToken);
        await appStoreBloc.updateAccessToken(model.accessToken);
        await appStoreBloc.updateUserId(model.userId);
        return ApiResponse(success: true, data: model, errors: []);
      }
      return _handleError(responseData);
    } catch (e) {
      return ApiResponse(success: false, errors: ['Something went wrong$e']);
    }
  }

  Future<bool> sendOtp(String email) async {
    var url = Uri.parse("${baseUrl}auth/send-otp");

    var encoded = jsonEncode({'email': email});

    try {
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: encoded,
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

    var encoded = jsonEncode({'email': email, 'otp': otp});

    try {
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: encoded,
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

    var encoded = jsonEncode({'email': email, 'newPassword': newPassword});

    try {
      var response = await http.post(
        url,
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: encoded,
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
        await appStoreBloc.updateAccessToken(accessToken);
        return accessToken;
      }

      return '';
    } catch (e) {
      return '';
    }
  }
}
