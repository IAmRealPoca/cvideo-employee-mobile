/*
 * File: scr001_authentication_state.dart
 * Project: CVideo
 * File Created: Saturday, 13th June 2020 12:00 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 12:00 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final FirebaseUser currentuser;

  const AuthenticationSuccess(this.currentuser);

  @override
  List<Object> get props => [currentuser];

  @override
  String toString() =>
      'Authenticated { displayName: ${currentuser.displayName} }';
}
