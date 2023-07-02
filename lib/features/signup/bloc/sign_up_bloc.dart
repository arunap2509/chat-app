import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignUpLoginButtonClickedEvent>(signUpLoginButtonClickedEvent);
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) {
    // emit(SignUpRegistrationLoadingState());
    emit(SignUpRegistrationSuccessState());
    // emit(SignUpRegistrationFailedState());
  }

  FutureOr<void> signUpLoginButtonClickedEvent(
      SignUpLoginButtonClickedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpNavigateToLoginPageState());
  }
}
