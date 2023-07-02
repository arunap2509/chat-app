// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_like_app/features/forgotpassword/bloc/forgot_password_bloc.dart';

import '../../../common/component/input_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final ForgotPasswordBloc forgotPasswordBloc;
  final String email;
  const ChangePasswordScreen({
    Key? key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.forgotPasswordBloc,
    required this.email,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  void handleChangePasswordButtonClick() {
    final password = widget.newPasswordController.text;
    final confirmPassword = widget.confirmPasswordController.text;

    if (password.isEmpty ||
        confirmPassword.isEmpty ||
        password != confirmPassword) {
      return;
    }

    widget.forgotPasswordBloc.add(
      ChangePasswordButtonClickedEvent(
        email: widget.email,
        newPassword: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              InputField(
                controller: widget.newPasswordController,
                isPassword: true,
                placeholder: 'New Password',
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                controller: widget.confirmPasswordController,
                isPassword: true,
                placeholder: 'Confirm Password',
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FilledButton(
                  onPressed: handleChangePasswordButtonClick,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Colors.green.shade400,
                    ),
                  ),
                  child: const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
