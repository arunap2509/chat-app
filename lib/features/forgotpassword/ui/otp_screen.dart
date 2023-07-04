// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_like_app/features/forgotpassword/bloc/forgot_password_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    required this.firstDigitController,
    required this.secondDigitController,
    required this.thirdDigitController,
    required this.fourthDigitController,
    required this.forgotPasswordBloc,
    required this.email,
  }) : super(key: key);

  final TextEditingController firstDigitController;
  final TextEditingController secondDigitController;
  final TextEditingController thirdDigitController;
  final TextEditingController fourthDigitController;
  final ForgotPasswordBloc forgotPasswordBloc;
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool enableSubmit = false;
  String otpValue = '';

  @override
  void initState() {
    super.initState();

    widget.firstDigitController.addListener(checkIfAllFieldsAreFilled);
    widget.secondDigitController.addListener(checkIfAllFieldsAreFilled);
    widget.thirdDigitController.addListener(checkIfAllFieldsAreFilled);
    widget.fourthDigitController.addListener(checkIfAllFieldsAreFilled);
  }

  checkIfAllFieldsAreFilled() {
    var firstDigit = widget.firstDigitController.text;
    var secondDigit = widget.secondDigitController.text;
    var thirdDigit = widget.thirdDigitController.text;
    var fourthDigit = widget.fourthDigitController.text;

    if (firstDigit.isEmpty ||
        secondDigit.isEmpty ||
        thirdDigit.isEmpty ||
        fourthDigit.isEmpty) {
      toggleEnableSubmit(false);
      return;
    }
    toggleEnableSubmit(true);
    otpValue = firstDigit + secondDigit + thirdDigit + fourthDigit;
  }

  handleSubmitButtonClick() {
    widget.forgotPasswordBloc.add(
      SubmitButtonClickedEvent(
        otpValue: otpValue,
        email: widget.email,
      ),
    );
  }

  toggleEnableSubmit(bool value) {
    setState(() {
      enableSubmit = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Please enter the otp that you have received in your registered email address",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w200,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpInput(
              controller: widget.firstDigitController,
              isFirstField: true,
            ),
            const SizedBox(
              width: 10,
            ),
            OtpInput(
              controller: widget.secondDigitController,
            ),
            const SizedBox(
              width: 10,
            ),
            OtpInput(
              controller: widget.thirdDigitController,
            ),
            const SizedBox(
              width: 10,
            ),
            OtpInput(
              controller: widget.fourthDigitController,
              isLastField: true,
            ),
          ],
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
            onPressed: enableSubmit ? handleSubmitButtonClick : null,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                Colors.green.shade400,
              ),
              // elevation: const MaterialStatePropertyAll<double>(1),
              // splashFactory: NoSplash.splashFactory,
            ),
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isLastField;
  final bool isFirstField;
  const OtpInput({
    super.key,
    required this.controller,
    this.isLastField = false,
    this.isFirstField = false,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 8),
          child: TextField(
            autofocus: true,
            controller: widget.controller,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: "",
              isDense: true,
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
            keyboardType: TextInputType.number,
            showCursor: false,
            maxLength: 1,
            onChanged: (value) {
              if ((widget.isLastField && value.isNotEmpty) ||
                  (widget.isFirstField && value.isEmpty)) {
                FocusScope.of(context).unfocus();
              } else {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  FocusScope.of(context).previousFocus();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
