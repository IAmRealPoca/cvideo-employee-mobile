/*
 * File: scr010_recruitment_detail_state.dart
 * Project: CVideo
 * File Created: Monday, 22nd June 2020 4:39:21 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 22nd June 2020 5:00:17 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

class RecruitmentDetailState extends Equatable {
  const RecruitmentDetailState();

  @override
  List<Object> get props => [];
}

class RecruitmentDetailFetchInitial extends RecruitmentDetailState {}

class RecruitmentDetailFetching extends RecruitmentDetailState {}

class RecruitmentDetailFetchedSuccess extends RecruitmentDetailState {
  final RecruitmentPost recruitmentPost;
  RecruitmentDetailFetchedSuccess({this.recruitmentPost});

  @override
  List<Object> get props => [recruitmentPost];
  @override
  String toString() => ' Recruitment post load success';
}

class RecruitmentDetailFetchedFailure extends RecruitmentDetailState {
  @override
  String toString() => ' Recruitment post load fail';
}
