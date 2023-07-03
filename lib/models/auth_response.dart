import 'dart:convert';

class AuthResponse {
  final String userId;
  final String refreshToken;
  final String accessToken;
  AuthResponse({
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

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      userId: map['userId'] as String,
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
