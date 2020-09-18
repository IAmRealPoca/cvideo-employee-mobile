/*
 * File: scr012_recruitment_list_event.dart
 * Project: CVideo
 * File Created: Tuesday, 30th June 2020 6:44:50 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 30th June 2020 6:46:52 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class RecruitmentListEvent extends Equatable {
  const RecruitmentListEvent();
  @override
  List<Object> get props => [];
}

class RecruitmentListFetched extends RecruitmentListEvent {
  final String url;
  RecruitmentListFetched(this.url);
}
