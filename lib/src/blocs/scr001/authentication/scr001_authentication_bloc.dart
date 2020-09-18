/*
 * File: scr001_authentication_bloc.dart
 * Project: CVideo
 * File Created: Saturday, 13th June 2020 12:00 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 12:00 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'dart:async';
import 'dart:convert';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository _loginRepository;
  final FirebaseMessaging _firebaseMessaging;

  AuthenticationBloc(
      {@required LoginRepository loginRepository,
      @required FirebaseMessaging firebaseMessaging})
      : assert(loginRepository != null),
        _loginRepository = loginRepository,
        _firebaseMessaging = firebaseMessaging;

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _loginRepository.isSignedIn();

    final apiToken = await AppStorage.instance.readSecureApiToken();

    if (isSignedIn) {
      /// Check is token is stored or not
      if (apiToken == null || apiToken.isEmpty) {
        _loginRepository.signOut();
        yield AuthenticationFailure();
        return;
      }

      /// Get current user
      final currentUser = await _loginRepository.getUser();

      /// Send fcm token to server
      var fcmToken = await _firebaseMessaging.getToken();

      /// Send fcm's token to server
      AppHttpClient.post(
        "/fcm/devices",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $apiToken"
        },
        body: jsonEncode({"deviceId": "$fcmToken"}),
      );

      yield AuthenticationSuccess(currentUser);
    } else {
      _firebaseMessaging.getToken().then((fcmToken) {
        AppHttpClient.post(
          "/fcm/devices",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"deviceId": "$fcmToken"}),
        );
      });

      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await _loginRepository.getUser());
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    await AppStorage.instance.writeSecureApiToken("");
    await _loginRepository.signOut();
    yield AuthenticationFailure();
  }
}
