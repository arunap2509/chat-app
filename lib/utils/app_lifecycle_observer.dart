// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_like_app/features/login/ui/login_screen.dart';
import 'package:chat_like_app/home_screen.dart';
import 'package:chat_like_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:chat_like_app/cubit/app_store.dart';

class AppLifeCycleObserver with WidgetsBindingObserver {
  final AppStoreBloc appStoreBloc;
  final GlobalKey<NavigatorState> navigationState;

  AppLifeCycleObserver({
    required this.appStoreBloc,
    required this.navigationState,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        await fetchDateFromDevice();
        if (appStoreBloc.state.accessToken.isEmpty) {
          navigationState.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        } else {
          navigationState.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }
        break;
      case AppLifecycleState.inactive:
        //print("app is inactive");
        break;
      case AppLifecycleState.paused:
        navigationState.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
        break;
      case AppLifecycleState.detached:
        //print("app is detached");
        break;
    }
  }

  // Register the observer
  void registerObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  // Unregister the observer
  void unregisterObserver() {
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<bool> fetchDateFromDevice() async {
    var accessToken = await appStoreBloc.deviceStorage
            .getStringValue(AppConstants.accessToken) ??
        '';
    var refreshToken = await appStoreBloc.deviceStorage
            .getStringValue(AppConstants.refreshToken) ??
        '';
    var email =
        await appStoreBloc.deviceStorage.getStringValue(AppConstants.email) ??
            '';
    var userName = await appStoreBloc.deviceStorage
            .getStringValue(AppConstants.userName) ??
        '';
    var userId =
        await appStoreBloc.deviceStorage.getStringValue(AppConstants.userId) ??
            '';

    if (accessToken.isEmpty) {
      return false;
    }

    appStoreBloc.updateAccessToken(accessToken);
    appStoreBloc.updateRefreshToken(refreshToken);
    appStoreBloc.updateEmail(email);
    appStoreBloc.updateUserId(userId);
    appStoreBloc.updateUserName(userName);

    return true;
  }
}
