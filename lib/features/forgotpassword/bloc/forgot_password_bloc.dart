import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthService authService;
  ForgotPasswordBloc({required this.authService})
      : super(ForgotPasswordInitial()) {
    on<SendOtpButtonClickedEvent>(sendOtpButtonClickedEvent);
    on<SubmitButtonClickedEvent>(submitButtonClickedEvent);
    on<ChangePasswordButtonClickedEvent>(changePasswordButtonClickedEvent);
  }

  FutureOr<void> sendOtpButtonClickedEvent(SendOtpButtonClickedEvent event,
      Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoadingState());
    var response = await authService.sendOtp(event.email);
    if (response) {
      emit(
        ForgotPasswordSendOtpSuccessState(email: event.email),
      );
    } else {
      emit(
        ForgotPasswordErrorState(errorMessage: "Invalid email address"),
      );
    }
  }

  FutureOr<void> submitButtonClickedEvent(
      SubmitButtonClickedEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoadingState());
    var response = await authService.verifyOtp(event.email, event.otpValue);
    if (response) {
      emit(
        ForgotPasswordSubmitSuccessState(email: event.email),
      );
    } else {
      emit(
        ForgotPasswordErrorState(errorMessage: "Please enter valid otp"),
      );
    }
  }

  FutureOr<void> changePasswordButtonClickedEvent(
      ChangePasswordButtonClickedEvent event,
      Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoadingState());
    var response =
        await authService.changePassword(event.email, event.newPassword);

    if (response) {
      emit(ForgotPasswordChangePasswordSuccessState());
    } else {
      emit(
        ForgotPasswordErrorState(
          errorMessage: "Something went wrong, please try again after sometime",
        ),
      );
    }
  }
}
