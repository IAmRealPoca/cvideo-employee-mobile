/*
 * File: question_set.dart
 * Project: CVideo
 * File Created: Saturday, 4th July 2020 10:22 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:48 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class QuestionSet extends Equatable {
  final int id;
  final String name;

  QuestionSet({@required this.id, @required this.name});

  @override
  List<Object> get props => [
        this.id,
        this.name,
      ];

  static QuestionSet fromJson(dynamic json) {
    return QuestionSet(
      id: json['setId'] as int,
      name: json['setName'] as String,
    );
  }
}
