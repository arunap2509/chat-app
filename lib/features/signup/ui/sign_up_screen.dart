import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/component/input_field.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  void _navigateToHomePage(String userId) {
    Navigator.pushNamed(context, '/home', arguments: {'userId': userId},);
  }

  void _navigateToLoginPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = SignUpBloc(authService: Provider.of<AuthService>(context));
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: bloc,
      listenWhen: (previous, current) => current is SignUpActionState,
      buildWhen: (previous, current) => current is! SignUpActionState,
      listener: (context, state) {
        if (state is SignUpNavigateToLoginPageState) {
          _navigateToLoginPage();
        } else if (state is SignUpRegistrationFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(state),
          );
        } else if (state is SignUpRegistrationSuccessState) {
          _navigateToHomePage(state.userId);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignUpInitial:
          case SignUpRegistrationHideLoadingState:
            return SignUpPage(
              emailController: emailController,
              userNameController: userNameController,
              passwordController: passwordController,
              phoneNumberController: phoneNumberController,
              signupBloc: bloc,
            );
          case SignUpRegistrationLoadingState:
            return SignUpPage(
              emailController: emailController,
              userNameController: userNameController,
              passwordController: passwordController,
              phoneNumberController: phoneNumberController,
              signupBloc: bloc,
              showLoadingScreen: true,
            );
          default:
            return Container();
        }
      },
    );
  }

  SnackBar errorSnackBar(SignUpRegistrationFailedState state) {
    return SnackBar(
      content: Column(
        children: [
          for (int i = 0; i < state.errors.length; i++)
            Row(children: [
              const Text("\u2022"),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  state.errors[i],
                ), //text
              )
            ])
        ],
      ),
      backgroundColor: Colors.red.shade300,
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.emailController,
    required this.userNameController,
    required this.passwordController,
    required this.signupBloc,
    this.showLoadingScreen = false,
    required this.phoneNumberController,
  });

  final TextEditingController emailController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;
  final SignUpBloc signupBloc;
  final bool showLoadingScreen;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void handleSignupButtonClick() {
    final email = widget.emailController.text;
    final password = widget.passwordController.text;
    final username = widget.userNameController.text;
    final phoneNumber = widget.phoneNumberController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        username.isEmpty ||
        phoneNumber.isEmpty ||
        phoneNumber.length != 10) {
      return;
    }

    widget.signupBloc.add(
      SignUpButtonClickedEvent(
        email: email,
        password: password,
        userName: username,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 24,
                  right: 24,
                  bottom: 24,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InputField(
                      placeholder: 'Email',
                      controller: widget.emailController,
                    ),
                    InputField(
                      placeholder: 'PhoneNumber',
                      controller: widget.phoneNumberController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InputField(
                      placeholder: 'UserName',
                      controller: widget.userNameController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InputField(
                      controller: widget.passwordController,
                      isPassword: true,
                      placeholder: 'Password',
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
                        onPressed: handleSignupButtonClick,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.green.shade400,
                          ),
                        ),
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      height: 20,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text("Already have an account? "),
                              GestureDetector(
                                onTap: () {
                                  widget.signupBloc.add(
                                    SignUpLoginButtonClickedEvent(),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (widget.showLoadingScreen)
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
