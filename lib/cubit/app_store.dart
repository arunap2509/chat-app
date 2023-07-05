// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:chat_like_app/utils/app_constants.dart';
import 'package:chat_like_app/utils/device_storage.dart';

class Store {
  final String accessToken;
  final String refreshToken;
  final String userName;
  final String email;
  final String userId;
  Store({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required this.email,
    required this.userId,
  });

  Store copyWith({
    String? accessToken,
    String? refreshToken,
    String? userName,
    String? email,
    String? userId,
  }) {
    return Store(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      userId: userId ?? this.userId,
    );
  }

  static Store getInitalState() {
    return Store(
      accessToken: '',
      refreshToken: '',
      userName: '',
      email: '',
      userId: '',
    );
  }
}

class AppStoreBloc extends Cubit<Store> {
  static final AppStoreBloc instance = AppStoreBloc._internal();
  DeviceStorage deviceStorage = DeviceStorage();
  factory AppStoreBloc() {
    return instance;
  }

  AppStoreBloc._internal() : super(Store.getInitalState());

  Future updateAccessToken(String accessToken) async {
    emit(state.copyWith(accessToken: accessToken));
    await deviceStorage.saveStringValue(AppConstants.accessToken, accessToken);
  }

  Future updateRefreshToken(String refreshToken) async {
    emit(state.copyWith(refreshToken: refreshToken));
    await deviceStorage.saveStringValue(
        AppConstants.refreshToken, refreshToken);
  }

  Future updateEmail(String email) async {
    emit(state.copyWith(email: email));
    await deviceStorage.saveStringValue(AppConstants.email, email);
  }

  Future updateUserName(String userName) async {
    emit(state.copyWith(userName: userName));
    await deviceStorage.saveStringValue(AppConstants.userName, userName);
  }

  Future updateUserId(String userId) async {
    emit(state.copyWith(userId: userId));
    await deviceStorage.saveStringValue(AppConstants.userId, userId);
  }
}
