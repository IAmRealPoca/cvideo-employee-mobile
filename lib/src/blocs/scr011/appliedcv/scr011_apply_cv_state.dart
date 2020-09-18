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

class ApplyCVState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApplyCVInitial extends ApplyCVState {}

class ApplyCVProcessing extends ApplyCVState {}

class ApplyCVSuccess extends ApplyCVState {
  final String message;
  ApplyCVSuccess({this.message});

  @override
  String toString() => ' Applied CV success';
}

class ApplyCVFailure extends ApplyCVState {
  @override
  String toString() => ' Applied CV fail';
}
