/*
 * File: scr001_login_bloc.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 7:53 pm
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
import 'package:cvideo_mobile/src/app_components/app_storage.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final FirebaseMessaging _firebaseMessaging;

  LoginBloc(
      {@required LoginRepository loginRepository,
      @required FirebaseMessaging firebaseMessaging})
      : assert(loginRepository != null),
        _loginRepository = loginRepository,
        _firebaseMessaging = firebaseMessaging;

  @override
  LoginState get initialState => LoginStateInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield LoginStateLoading();
      //GoogleSignIn googleSignIn = new GoogleSignIn();
      FirebaseUser currentUser = await _loginRepository.signIn();

      var idToken = await currentUser.getIdToken();

      var googleResponse = await AppHttpClient.post(
        "/auth/google",
        headers: {"Content-Type": "application/json"},

        /// Flg = 1 for employer
        body: jsonEncode(
            <String, String>{'token': '${idToken.token}', 'flg': '1'}),
      );

      if (googleResponse.statusCode != 200) {
        _loginRepository.signOut();
        yield LoginStateFailure(errMsg: SCR001Constants.API_TOKEN_ERR);
        return;
      }

      /// Get token from server's repnse
      String token = jsonDecode(googleResponse.body)["token"];

      // Create storage
      AppStorage appStorage = AppStorage.instance;

      /// Write token to storage
      await appStorage.writeSecureApiToken(token);

      /// Send fcm token to server
      var fcmToken = await _firebaseMessaging.getToken();

      /// Send fcm's token to server
      await AppHttpClient.post(
        "/fcm/devices",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: jsonEncode({"deviceId": "$fcmToken"}),
      );

      yield LoginStateSuccess();
    } catch (_) {
      yield LoginStateFailure(errMsg: SCR001Constants.LOGIN_FAIL_ERR);
    }
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    yield LoginStateSuccess();
  }
}
