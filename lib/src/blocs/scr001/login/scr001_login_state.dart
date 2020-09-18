/*
 * File: scr001_login_state.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 7:53 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 3:39 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateSuccess extends LoginState {}
 
class LoginStateLoading extends LoginState {}

class LoginStateFailure extends LoginState {
  final String errMsg;

  LoginStateFailure({this.errMsg});
}