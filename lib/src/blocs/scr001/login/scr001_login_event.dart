/*
 * File: scr001_login_event.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 7:53 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 12:01 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithFacebookPressed extends LoginEvent {}
