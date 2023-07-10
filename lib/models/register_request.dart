// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterRequest {
  final String email;
  final String userName;
  final String password;
  final String phoneNumber;
  RegisterRequest({
    required this.email,
    required this.userName,
    required this.password,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'userName': userName,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      email: map['email'] as String,
      userName: map['userName'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
