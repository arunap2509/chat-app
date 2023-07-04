// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

abstract class ForgotPasswordActionState extends ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordHideLoadingState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordActionState {
  final String errorMessage;
  ForgotPasswordErrorState({
    required this.errorMessage,
  });
}

class ForgotPasswordSendOtpSuccessState extends ForgotPasswordState {
  final String email;
  ForgotPasswordSendOtpSuccessState({
    required this.email,
  });
}

class ForgotPasswordSubmitSuccessState extends ForgotPasswordState {
  final String email;
  ForgotPasswordSubmitSuccessState({
    required this.email,
  });
}

class ForgotPasswordChangePasswordSuccessState
    extends ForgotPasswordActionState {}
