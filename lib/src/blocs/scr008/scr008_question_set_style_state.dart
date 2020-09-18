/*
 * File: scr008_question_set_style_state.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 10:39 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:47 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/models/scr008/scr008_models.dart';
import 'package:equatable/equatable.dart';

abstract class QuestionSetStyleState extends Equatable {
  const QuestionSetStyleState();

  @override
  List<Object> get props => [];
}

class QuestionSetStyleInitial extends QuestionSetStyleState {}

class QuestionSetStyleFailure extends QuestionSetStyleState {}

class QuestionSetStyleSuccess extends QuestionSetStyleState {
  final List<QuestionSet> listQuestionSet;
  final List<VideoStyle> listStyle;

  const QuestionSetStyleSuccess({this.listQuestionSet, this.listStyle});

  @override
  List<Object> get props => [listQuestionSet, listStyle];

  @override
  String toString() =>
    'QuestionSetStyleSuccess { listQuestionSet: ${listQuestionSet.length}, listStyle: ${listStyle.length} }';
}
