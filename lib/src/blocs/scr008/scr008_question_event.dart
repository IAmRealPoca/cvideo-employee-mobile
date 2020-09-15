/*
 * File: scr008_question_event.dart
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
import 'package:meta/meta.dart';

abstract class QuestionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionFetched extends QuestionEvent {
  final int setId;

  QuestionFetched({@required this.setId});

}