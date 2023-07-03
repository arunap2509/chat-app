import 'package:chat_like_app/features/login/ui/login_screen.dart';
import 'package:chat_like_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cubit/app_store.dart';

void main() {
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
        // Provider<ChatService>(
        //   create: (context) => ChatService(
        //     appStoreBloc: Provider.of<AppStoreBloc>(context, listen: false),
        //   ),
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
