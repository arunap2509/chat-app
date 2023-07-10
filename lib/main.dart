// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_like_app/features/chat/ui/chat_screen.dart';
import 'package:chat_like_app/features/forgotpassword/ui/forgot_password_screen.dart';
import 'package:chat_like_app/features/signup/ui/sign_up_screen.dart';
import 'package:chat_like_app/websocket/websocket_connector.dart';
import 'features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_like_app/features/login/ui/login_screen.dart';
import 'package:chat_like_app/services/auth_service.dart';
import 'package:chat_like_app/utils/app_lifecycle_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/app_store.dart';

void main() async {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  var instance = await SharedPreferences.getInstance();
  instance.setString("", "");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppStoreBloc>(
          create: (context) => AppStoreBloc(),
        ),
        Provider<AuthService>(
          create: (context) => AuthService(
            appStoreBloc: Provider.of<AppStoreBloc>(context, listen: false),
          ),
        ),
        Provider<Websocket>(
          create: (context) => Websocket(),
        ),
      ],
      child: const AppStart(),
    );
  }
}

class AppStart extends StatefulWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  late AppLifeCycleObserver appLifecycleObserver;
  late GlobalKey<NavigatorState> navigatorKey;

  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey<NavigatorState>();
    appLifecycleObserver = AppLifeCycleObserver(
      appStoreBloc: Provider.of<AppStoreBloc>(context, listen: false),
      navigationState: navigatorKey,
    );
    appLifecycleObserver.registerObserver();
  }

  @override
  void dispose() {
    super.dispose();
    appLifecycleObserver.unregisterObserver();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/forgot-password': (context) => const ForgotPassword(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') {
          var arguments = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
              builder: (context) => ChatScreen(name: arguments['userName']!));
        } else if (settings.name == '/home') {
          var arguments = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
              builder: (context) => HomeScreen(userId: arguments['userId']!));
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      home: const LoginScreen(),
    );
  }
}
