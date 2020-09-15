/*
 * File: home_state.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 9:11:07 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 12th June 2020 9:57:21 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class RecruitmentState extends Equatable {
  const RecruitmentState();

  @override
  List<Object> get props => [];
}

class UninitialisedRecruitmentState extends RecruitmentState {}

class RecruitmentFetching extends RecruitmentState {}

class RecruitmentFetchSuccess extends RecruitmentState {
  final List<SectionInfo> sectionInfoList;
  RecruitmentFetchSuccess({this.sectionInfoList});
  @override
  List<Object> get props => [sectionInfoList];

  @override
  String toString() => ' Section Information list load success';
}

class RecruitmentFetchFailure extends RecruitmentState {
  @override
  String toString() => ' Section Information list load fail';
}
