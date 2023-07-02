part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginAuthenticationLoadingState extends LoginState {}

class LoginAuthenticationSuccessState extends LoginActionState {}

class LoginAuthenticationErrorState extends LoginActionState {}

class LoginNavigateToForgotPassword extends LoginActionState {}

class LoginNavigateToSignUp extends LoginActionState {}
