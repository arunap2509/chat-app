part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String userName;
  final String password;
  LoginButtonClickedEvent({
    required this.userName,
    required this.password,
  });
}

class ForgotPasswordButtonClickedEvent extends LoginEvent {}

class SignUpButtonClickedEvent extends LoginEvent {}
