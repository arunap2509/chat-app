// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginAuthenticationLoadingState extends LoginState {}

class LoginAuthenticationSuccessState extends LoginActionState {
  final String userId;
  LoginAuthenticationSuccessState({
    required this.userId,
  });
}

class LoginAuthenticationErrorState extends LoginActionState {
  final List<String> errors;
  LoginAuthenticationErrorState({
    required this.errors,
  });
}

class LoginNavigateToForgotPassword extends LoginActionState {}

class LoginNavigateToSignUp extends LoginActionState {}
