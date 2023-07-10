// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonClickedEvent extends SignUpEvent {
  final String userName;
  final String password;
  final String email;
  final String phoneNumber;

  SignUpButtonClickedEvent({
    required this.userName,
    required this.password,
    required this.email,
    required this.phoneNumber,
  });
}

class SignUpLoginButtonClickedEvent extends SignUpEvent {}
