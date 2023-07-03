import 'package:chat_like_app/features/signup/ui/sign_up_screen.dart';
import 'package:chat_like_app/home_screen.dart';
import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/component/input_field.dart';
import '../../forgotpassword/ui/forgot_password_screen.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = LoginBloc(
        authService: Provider.of<AuthService>(context, listen: false));
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => current is! LoginActionState,
      listenWhen: (previous, current) => current is LoginActionState,
      listener: (context, state) {
        if (state is LoginNavigateToForgotPassword) {
          _navigateToForgotPassword();
        } else if (state is LoginNavigateToSignUp) {
          _navigateToSignUp();
        } else if (state is LoginAuthenticationSuccessState) {
          _navigateToHomeScreen();
        } else if (state is LoginAuthenticationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error occured while trying to login'),
              backgroundColor: Colors.red.shade300,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginInitial:
            return LoginPage(
              userNameController: userNameController,
              passwordController: passwordController,
              loginBloc: bloc,
            );
          case LoginAuthenticationLoadingState:
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

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required this.loginBloc,
  });

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final LoginBloc loginBloc;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void handleLoginButtonClick() {
    final username = widget.userNameController.text;
    final password = widget.passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      return;
    }

    widget.loginBloc
        .add(LoginButtonClickedEvent(password: password, userName: username));
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SafeArea(
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
                          "Login",
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
                    height: 4,
                  ),
                  SizedBox(
                    height: 14,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.loginBloc
                                .add(ForgotPasswordButtonClickedEvent());
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.green.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      onPressed: handleLoginButtonClick,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.green.shade400,
                        ),
                      ),
                      child: const Text(
                        "Login",
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
                            const Text("Don't have account? "),
                            GestureDetector(
                              onTap: () {
                                widget.loginBloc
                                    .add(SignUpButtonClickedEvent());
                              },
                              child: Text(
                                "SignUp",
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
      ),
    );
  }
}
