part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonClickedEvent extends SignUpEvent {
  final String userName;
  final String password;
  final String email;

  SignUpButtonClickedEvent({
    required this.userName,
    required this.password,
    required this.email,
  });
}

class SignUpLoginButtonClickedEvent extends SignUpEvent {}
