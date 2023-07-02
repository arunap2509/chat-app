// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class SendOtpButtonClickedEvent extends ForgotPasswordEvent {
  final String email;
  SendOtpButtonClickedEvent({
    required this.email,
  });
}

class SubmitButtonClickedEvent extends ForgotPasswordEvent {
  final String email;
  final String otpValue;
  SubmitButtonClickedEvent({
    required this.email,
    required this.otpValue,
  });
}

class ChangePasswordButtonClickedEvent extends ForgotPasswordEvent {
  final String email;
  final String newPassword;
  ChangePasswordButtonClickedEvent({
    required this.email,
    required this.newPassword,
  });
}
