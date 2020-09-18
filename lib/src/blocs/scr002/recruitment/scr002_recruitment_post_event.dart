/*
 * File: scr002_recruitment_post_event.dart
 * Project: CVideo
 * File Created: Monday, 29th June 2020 3:36:00 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 29th June 2020 3:37:09 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class RecruitmentPostEvent extends Equatable {
  const RecruitmentPostEvent();
  @override
  List<Object> get props => [];
}
class RecruitmentPostFetched extends RecruitmentPostEvent {
  final String url;
  RecruitmentPostFetched(this.url);
}
