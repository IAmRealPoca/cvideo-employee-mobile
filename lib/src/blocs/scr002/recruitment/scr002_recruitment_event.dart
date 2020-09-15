/*
 * File: home_event.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 9:11:16 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 12th June 2020 9:24:19 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class RecruitmentEvent extends Equatable {
  const RecruitmentEvent();
}

class RecruitmentFetched extends RecruitmentEvent {
  final String lang;
  RecruitmentFetched({this.lang});
  @override
  List<Object> get props => [];
}
