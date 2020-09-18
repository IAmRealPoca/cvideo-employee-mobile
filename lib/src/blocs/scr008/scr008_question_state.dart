/*
 * File: scr008_question_state.dart
 * Project: CVideo
 * File Created: Wednesday, 8th July 2020 4:37 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:08 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionFailure extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionSuccess extends QuestionState {
  final String jsonQuestions;

  const QuestionSuccess({this.jsonQuestions});

  @override
  List<Object> get props => [jsonQuestions];

  @override
  String toString() =>
    'QuestionSuccess { listQuestion: $jsonQuestions }';
}
