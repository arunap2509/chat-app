import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<ForgotPasswordButtonClickedEvent>(forgotPasswordButtonClickedEvent);
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) {
    // emit(LoginAuthenticationLoadingState());
    // call the api

    // if success 200
    emit(LoginAuthenticationSuccessState());
    // print(event.password + event.userName);
    // if error
    //emit(LoginAuthenticationErrorState());
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToSignUp());
  }

  FutureOr<void> forgotPasswordButtonClickedEvent(
      ForgotPasswordButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToForgotPassword());
  }
}
