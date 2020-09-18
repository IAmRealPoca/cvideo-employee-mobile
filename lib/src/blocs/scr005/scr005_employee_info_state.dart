/*
 * File: scr011_apply_cv_state.dart
 * Project: CVideo
 * File Created: Thursday, 2nd July 2020 10:49:37 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 3rd July 2020 11:44:49 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

class UpdateEmployeeInfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateEmployeeInfoInitial extends UpdateEmployeeInfoState {}

class UpdateEmployeeInfoProcessing extends UpdateEmployeeInfoState {}

class UpdateEmployeeInfoSuccess extends UpdateEmployeeInfoState {
  final String message;
  UpdateEmployeeInfoSuccess({this.message});

  @override
  String toString() => ' Updated employee information success';
}

class UpdateEmployeeInfoFailure extends UpdateEmployeeInfoState {
  @override
  String toString() => ' Updated employee information fail';
}
