/*
 * File: scr011_cv_state.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 9:03:00 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Thursday, 25th June 2020 4:27:35 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

class CVListState extends Equatable {
  const CVListState();
  @override
  List<Object> get props => [];
}

class CVListInitial extends CVListState {}

class CVListFetching extends CVListState {}

class CVListFetchedSucess extends CVListState {
  final List<CV> cvlists;
  const CVListFetchedSucess({this.cvlists});

  @override
  String toString() => 'Loading CV list success';
}

class CVListFetchedFailure extends CVListState {
  @override
  String toString() => 'Fail to loading CV list';
}
