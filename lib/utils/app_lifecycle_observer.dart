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
          navigationState.currentState?.pushReplacementNamed('/login');
        } else {
          navigationState.currentState?.pushNamed('/home');
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
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
