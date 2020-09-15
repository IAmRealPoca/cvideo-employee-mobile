/*
 * File: login_repository.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 9:27 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 5:00 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<FirebaseUser> signIn();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<FirebaseUser> getUser();
}