/*
 * File: scr012_recruitment_list_state.dart
 * Project: CVideo
 * File Created: Tuesday, 30th June 2020 6:45:08 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 30th June 2020 6:48:55 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

class RecruitmentListState extends Equatable {
  const RecruitmentListState();

  @override
  List<Object> get props => [];
}

class RecruitmentListFetchInitial extends RecruitmentListState {}

class RecruitmentListFetching extends RecruitmentListState {}

class RecruitmentListFetchedSuccess extends RecruitmentListState {
  final List<RecruitmentPost> recruitmentPostList;
  final bool hasReachedMax;
  RecruitmentListFetchedSuccess({this.recruitmentPostList, this.hasReachedMax});

  RecruitmentListFetchedSuccess copyWith({
    List<RecruitmentPost> recruitmentPostList,
    bool hasReachedMax,
  }) {
    return RecruitmentListFetchedSuccess(
        recruitmentPostList: recruitmentPostList ?? this.recruitmentPostList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [recruitmentPostList, hasReachedMax];
  

  @override
  String toString() => ' Recruitment post load success';
}

class RecruitmentListFetchedFailure extends RecruitmentListState {
  @override
  String toString() => ' Recruitment post load fail';
}
