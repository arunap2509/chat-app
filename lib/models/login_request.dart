// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequest {
  final String userName;
  final String password;
  LoginRequest({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      userName: map['userName'] as String,
      password: map['password'] as String,
    );
  }

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
