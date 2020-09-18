/*
 * File: scr002_recruitment_post_state.dart
 * Project: CVideo
 * File Created: Monday, 29th June 2020 3:36:21 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 29th June 2020 3:56:57 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

class RecruitmentPostState extends Equatable {
  const RecruitmentPostState();

  @override
  List<Object> get props => [];
}

class RecruitmentPostFetchInitial extends RecruitmentPostState {}

class RecruitmentPostFetching extends RecruitmentPostState {}

class RecruitmentPostFetchedSuccess extends RecruitmentPostState {
  final List<RecruitmentPost> recruitmentPostList;
  RecruitmentPostFetchedSuccess({this.recruitmentPostList});

  @override
  List<Object> get props => [recruitmentPostList];

  @override
  String toString() => ' Recruitment post load success';
}

class RecruitmentPostFetchedFailure extends RecruitmentPostState {
  @override
  String toString() => ' Recruitment post load fail';
}
