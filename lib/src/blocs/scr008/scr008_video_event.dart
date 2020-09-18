/*
 * File: scr008_video_event.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 1:53 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:09 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class VideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event when dropdown for question set change
class VideoEventQuestionSetChanged extends VideoEvent {
  final int questionSetId;

  VideoEventQuestionSetChanged({@required this.questionSetId});

  @override
  List<Object> get props => [this.questionSetId];
}

/// Event when dropdown for style change
class VideoEventStyleChanged extends VideoEvent {
  final int videoStyleId;

  VideoEventStyleChanged({@required this.videoStyleId});

  @override
  List<Object> get props => [this.videoStyleId];
}

/// Event when user press record video
class VideoEventRecorded extends VideoEvent {
  final String jsonQuestions;

  VideoEventRecorded({@required this.jsonQuestions});

  @override
  List<Object> get props => [this.jsonQuestions];
}

class VideoEventUploaded extends VideoEvent {}
