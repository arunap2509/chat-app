import 'package:flutter/material.dart';

import '../../../common/component/input_field.dart';
import '../bloc/forgot_password_bloc.dart';

class VerifyEmail extends StatefulWidget {
  final ForgotPasswordBloc forgotPasswordBloc;
  const VerifyEmail(
      {super.key,
      required this.emailController,
      required this.forgotPasswordBloc});

  final TextEditingController emailController;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  handleSendOtpButtonClick() {
    final email = widget.emailController.text;

    if (email.isEmpty) {
      return;
    }

    widget.forgotPasswordBloc.add(
      SendOtpButtonClickedEvent(email: widget.emailController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            const Text(
              "Please enter your registered email address to send otp for verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InputField(
              placeholder: 'Email',
              controller: widget.emailController,
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
                onPressed: handleSendOtpButtonClick,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Colors.green.shade400,
                  ),
                ),
                child: const Text(
                  "Send Otp",
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
    );
  }
}
