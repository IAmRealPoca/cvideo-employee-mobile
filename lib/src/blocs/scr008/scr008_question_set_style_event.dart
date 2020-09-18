/*
 * File: scr008_question_set_style_event.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 10:39 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:47 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class QuestionSetStyleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionSetStyleFetched extends QuestionSetStyleEvent {
  final int sectionId;

  QuestionSetStyleFetched({@required this.sectionId});

  @override
  List<Object> get props => [];
}
