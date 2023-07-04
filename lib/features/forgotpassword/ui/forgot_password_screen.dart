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
  var currentPageState = ForgotPasswordPageStage.verifyEmail;
  bool showLoader = false;
  String email = '';

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
            currentPageState = ForgotPasswordPageStage.verifyEmail;
            showLoader = false;
            break;
          case ForgotPasswordSendOtpSuccessState:
            final successState = state as ForgotPasswordSendOtpSuccessState;
            currentPageState = ForgotPasswordPageStage.otp;
            showLoader = false;
            email = successState.email;
            break;
          case ForgotPasswordSubmitSuccessState:
            final successState = state as ForgotPasswordSubmitSuccessState;
            currentPageState = ForgotPasswordPageStage.changePassword;
            showLoader = false;
            email = successState.email;
            break;
          case ForgotPasswordLoadingState:
            showLoader = true;
            break;
          case ForgotPasswordHideLoadingState:
            showLoader = false;
            break;
        }
        return ForgotPasswordPage(
          pageStage: currentPageState,
          firstDigitController: firstDigitController,
          secondDigitController: secondDigitController,
          thirdDigitController: thirdDigitController,
          fourthDigitController: fourthDigitController,
          emailController: emailController,
          newPasswordController: newPasswordController,
          confirmPasswordController: confirmPasswordController,
          forgotPasswordBloc: bloc,
          showLoader: showLoader,
          email: email,
        );
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
  final bool showLoader;
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
    this.showLoader = false,
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
      body: Listener(
        onPointerDown: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            child: Stack(
              children: [
                getBody(),
                if (widget.showLoader)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
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
