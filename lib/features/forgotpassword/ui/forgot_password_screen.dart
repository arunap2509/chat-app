// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/forgot_password_bloc.dart';
import '../forgot_password_page_stage_enum.dart';
import 'change_password_screen.dart';
import 'otp_screen.dart';
import 'verify_email.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController firstDigitController;
  late TextEditingController secondDigitController;
  late TextEditingController thirdDigitController;
  late TextEditingController fourthDigitController;
  late TextEditingController emailController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  bool enableSubmit = false;
  String otpValue = '';
  bool otpSend = false;
  bool otpVerfied = false;

  @override
  void initState() {
    super.initState();
    firstDigitController = TextEditingController();
    secondDigitController = TextEditingController();
    thirdDigitController = TextEditingController();
    fourthDigitController = TextEditingController();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    firstDigitController.dispose();
    secondDigitController.dispose();
    thirdDigitController.dispose();
    fourthDigitController.dispose();
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void _navigateToLoginPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bloc =
        ForgotPasswordBloc(authService: Provider.of<AuthService>(context));
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      bloc: bloc,
      listenWhen: (previous, current) => current is ForgotPasswordActionState,
      buildWhen: (previous, current) => current is! ForgotPasswordActionState,
      listener: (context, state) {
        if (state is ForgotPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Something went wrong'),
              backgroundColor: Colors.red.shade300,
            ),
          );
        } else if (state is ForgotPasswordChangePasswordSuccessState) {
          _navigateToLoginPage();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ForgotPasswordInitial:
            return ForgotPasswordPage(
              pageStage: ForgotPasswordPageStage.verifyEmail,
              firstDigitController: firstDigitController,
              secondDigitController: secondDigitController,
              thirdDigitController: thirdDigitController,
              fourthDigitController: fourthDigitController,
              emailController: emailController,
              newPasswordController: newPasswordController,
              confirmPasswordController: confirmPasswordController,
              forgotPasswordBloc: bloc,
            );
          case ForgotPasswordSendOtpSuccessState:
            final successState = state as ForgotPasswordSendOtpSuccessState;
            return ForgotPasswordPage(
              pageStage: ForgotPasswordPageStage.otp,
              firstDigitController: firstDigitController,
              secondDigitController: secondDigitController,
              thirdDigitController: thirdDigitController,
              fourthDigitController: fourthDigitController,
              emailController: emailController,
              newPasswordController: newPasswordController,
              confirmPasswordController: confirmPasswordController,
              forgotPasswordBloc: bloc,
              email: successState.email,
            );
          case ForgotPasswordSubmitSuccessState:
            final successState = state as ForgotPasswordSubmitSuccessState;
            return ForgotPasswordPage(
              pageStage: ForgotPasswordPageStage.changePassword,
              firstDigitController: firstDigitController,
              secondDigitController: secondDigitController,
              thirdDigitController: thirdDigitController,
              fourthDigitController: fourthDigitController,
              emailController: emailController,
              newPasswordController: newPasswordController,
              confirmPasswordController: confirmPasswordController,
              forgotPasswordBloc: bloc,
              email: successState.email,
            );
          case ForgotPasswordLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  final ForgotPasswordPageStage pageStage;
  final TextEditingController firstDigitController;
  final TextEditingController secondDigitController;
  final TextEditingController thirdDigitController;
  final TextEditingController fourthDigitController;
  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final ForgotPasswordBloc forgotPasswordBloc;
  final String email;
  const ForgotPasswordPage({
    Key? key,
    required this.pageStage,
    required this.firstDigitController,
    required this.secondDigitController,
    required this.thirdDigitController,
    required this.fourthDigitController,
    required this.emailController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.forgotPasswordBloc,
    this.email = '',
  }) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black45,
          ),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (widget.pageStage == ForgotPasswordPageStage.verifyEmail) {
      return VerifyEmail(
        emailController: widget.emailController,
        forgotPasswordBloc: widget.forgotPasswordBloc,
      );
    } else if (widget.pageStage == ForgotPasswordPageStage.otp) {
      return OtpScreen(
        firstDigitController: widget.firstDigitController,
        secondDigitController: widget.secondDigitController,
        thirdDigitController: widget.thirdDigitController,
        fourthDigitController: widget.fourthDigitController,
        forgotPasswordBloc: widget.forgotPasswordBloc,
        email: widget.email,
      );
    } else {
      return ChangePasswordScreen(
        confirmPasswordController: widget.confirmPasswordController,
        newPasswordController: widget.newPasswordController,
        forgotPasswordBloc: widget.forgotPasswordBloc,
        email: widget.email,
      );
    }
  }
}
