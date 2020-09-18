/*
 * File: firebase_login_repository.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 9:27 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 5:00 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './login_repository.dart';

class FirebaseLoginRepository implements LoginRepository {
  /// The [_firebaseAuth] is entry point of the Firebase Authentication SDK.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// The [_googleSignIn] allows you to authenticate Google users.
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static FirebaseLoginRepository _instance =
      FirebaseLoginRepository._internal();

  FirebaseLoginRepository._internal();

  factory FirebaseLoginRepository() {
    return _instance;
  }

  /// Start sign-in with google process
  /// Return the Future resovles to an instance of [FirebaseUser]
  Future<FirebaseUser> signIn() async {
    /// Start authentication with google and get [GoogleSignInAccount] after successful login.
    /// final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    /// Retrieve [GoogleSignInAuthentication] for this account.
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    /// Get [AuthCredential] from google's tokens
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    /// Asynchronously signs in to Firebase with the given Google credentials.
    await _firebaseAuth.signInWithCredential(credential);

    /// Returns the currently signed-in [FirebaseUser] or [null] if there is none.
    return _firebaseAuth.currentUser();
  }

  /// Sign out the account
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  /// Check if the user is already signed in
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  /// Get user's [FirebaseUser]
  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }
}
