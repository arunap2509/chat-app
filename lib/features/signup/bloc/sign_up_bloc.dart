import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_like_app/models/register_request.dart';
import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;
  SignUpBloc({required this.authService}) : super(SignUpInitial()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignUpLoginButtonClickedEvent>(signUpLoginButtonClickedEvent);
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpRegistrationLoadingState());
    var request = RegisterRequest(
      email: event.email,
      userName: event.userName,
      password: event.password,
      phoneNumber: event.phoneNumber,
    );
    var response = await authService.register(request);
    if (response.success) {
      emit(
        SignUpRegistrationSuccessState(userId: response.data!.userId),
      );
    } else {
      emit(SignUpRegistrationHideLoadingState());
      emit(SignUpRegistrationFailedState(errors: response.errors!));
    }
  }

  FutureOr<void> signUpLoginButtonClickedEvent(
      SignUpLoginButtonClickedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpNavigateToLoginPageState());
  }
}
