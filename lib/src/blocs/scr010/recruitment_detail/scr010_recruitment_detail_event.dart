/*
 * File: scr010_recruitment_detail_event.dart
 * Project: CVideo
 * File Created: Monday, 22nd June 2020 4:38:58 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 22nd June 2020 4:57:54 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

class RecruitmentDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecruitmentDetailRequest extends RecruitmentDetailEvent {
  final int postId;
  RecruitmentDetailRequest(this.postId);
}

class RecruitmentDetailFetched extends RecruitmentDetailEvent {
}
