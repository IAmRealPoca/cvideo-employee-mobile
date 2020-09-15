/*
 * File: scr011_cv_event.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 9:02:48 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 24th June 2020 9:05:07 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class CVListEvent extends Equatable {
  const CVListEvent();
}

class CVListFetched extends CVListEvent {
  final int majorId;
  CVListFetched({this.majorId});
  @override
  List<Object> get props => [];
}
