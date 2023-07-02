import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendOtpButtonClickedEvent>(sendOtpButtonClickedEvent);
    on<SubmitButtonClickedEvent>(submitButtonClickedEvent);
    on<ChangePasswordButtonClickedEvent>(changePasswordButtonClickedEvent);
  }

  FutureOr<void> sendOtpButtonClickedEvent(
      SendOtpButtonClickedEvent event, Emitter<ForgotPasswordState> emit) {
    // emit(ForgotPasswordLoadingState());
    // emit(ForgotPasswordErrorState());
    emit(ForgotPasswordSendOtpSuccessState(email: event.email));
  }

  FutureOr<void> submitButtonClickedEvent(
      SubmitButtonClickedEvent event, Emitter<ForgotPasswordState> emit) {
    // emit(ForgotPasswordLoadingState());
    // emit(ForgotPasswordErrorState());
    if (event.email.isEmpty) {
      emit(ForgotPasswordErrorState());
    } else {
      emit(ForgotPasswordSubmitSuccessState(email: event.email));
    }
  }

  FutureOr<void> changePasswordButtonClickedEvent(
      ChangePasswordButtonClickedEvent event,
      Emitter<ForgotPasswordState> emit) {
    // emit(ForgotPasswordLoadingState());
    // emit(ForgotPasswordErrorState());
    emit(ForgotPasswordChangePasswordSuccessState());
  }
}
