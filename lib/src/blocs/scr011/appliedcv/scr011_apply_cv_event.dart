/*
 * File: scr011_apply_cv_event.dart
 * Project: CVideo
 * File Created: Thursday, 2nd July 2020 10:49:54 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 3rd July 2020 11:39:16 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class ApplyCVEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ApplyCVRequest extends ApplyCVEvent {
  final int postId;
  final int cvId;

  ApplyCVRequest({this.postId, this.cvId});
}
