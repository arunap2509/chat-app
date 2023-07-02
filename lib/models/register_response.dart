// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterResponse {
  final String userId;
  final String refreshToken;
  final String accessToken;
  RegisterResponse({
    required this.userId,
    required this.refreshToken,
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'refreshToken': refreshToken,
      'accessToken': accessToken,
    };
  }

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    return RegisterResponse(
      userId: map['userId'] as String,
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromJson(String source) => RegisterResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
