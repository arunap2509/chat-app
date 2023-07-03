import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_like_app/models/login_request.dart';
import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<ForgotPasswordButtonClickedEvent>(forgotPasswordButtonClickedEvent);
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginAuthenticationLoadingState());

    var response = await authService.login(
      LoginRequest(userName: event.userName, password: event.password),
    );

    if (response.data != null) {
      emit(LoginAuthenticationSuccessState(userId: response.data!.userId));
    } else {
      emit(LoginAuthenticationErrorState(errors: response.errors!));
    }
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
