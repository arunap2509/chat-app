import 'package:chat_like_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final SignUpBloc signupBloc = SignUpBloc();
  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  void _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void _navigateToLoginPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: signupBloc,
      listenWhen: (previous, current) => current is SignUpActionState,
      buildWhen: (previous, current) => current is! SignUpActionState,
      listener: (context, state) {
        if (state is SignUpNavigateToLoginPageState) {
          _navigateToLoginPage();
        } else if (state is SignUpRegistrationFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Something went wrong"),
              backgroundColor: Colors.red.shade300,
            ),
          );
        } else if (state is SignUpRegistrationSuccessState) {
          _navigateToHomePage();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignUpInitial:
            return SignUpPage(
              emailController: emailController,
              userNameController: userNameController,
              passwordController: passwordController,
              signupBloc: signupBloc,
            );
          case SignUpRegistrationLoadingState:
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.emailController,
    required this.userNameController,
    required this.passwordController,
    required this.signupBloc,
  });

  final TextEditingController emailController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final SignUpBloc signupBloc;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void handleSignupButtonClick() {
    final email = widget.emailController.text;
    final password = widget.passwordController.text;
    final username = widget.userNameController.text;

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return;
    }

    widget.signupBloc.add(SignUpButtonClickedEvent(
      email: email,
      password: password,
      userName: username,
    ));
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
          child: Padding(
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
        ),
      ),
    );
  }
}
