// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

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

  factory AppStoreBloc() {
    return instance;
  }

  AppStoreBloc._internal() : super(Store.getInitalState());

  void updateAccessToken(String accessToken) {
    emit(state.copyWith(accessToken: accessToken));
  }

  void updateRefreshToken(String refreshToken) {
    emit(state.copyWith(refreshToken: refreshToken));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updateUserName(String userName) {
    emit(state.copyWith(userName: userName));
  }

  void updateUserId(String userId) {
    emit(state.copyWith(userId: userId));
  }
}
