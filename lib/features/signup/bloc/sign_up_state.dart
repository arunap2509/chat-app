// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

abstract class SignUpActionState extends SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpRegistrationLoadingState extends SignUpState {}

class SignUpRegistrationHideLoadingState extends SignUpState {}

class SignUpRegistrationFailedState extends SignUpActionState {
  final List<String> errors;
  SignUpRegistrationFailedState({
    required this.errors,
  });
}

class SignUpRegistrationSuccessState extends SignUpActionState {
  final String userId;
  SignUpRegistrationSuccessState({
    required this.userId,
  });
}

class SignUpNavigateToLoginPageState extends SignUpActionState {}
