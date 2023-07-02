part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

abstract class SignUpActionState extends SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpRegistrationLoadingState extends SignUpState {}

class SignUpRegistrationFailedState extends SignUpActionState {}

class SignUpRegistrationSuccessState extends SignUpActionState {}

class SignUpNavigateToLoginPageState extends SignUpActionState {}
