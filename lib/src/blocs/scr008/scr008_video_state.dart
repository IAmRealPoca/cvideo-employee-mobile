/*
 * File: scr008_video_state.dart
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
import 'package:flutter/cupertino.dart';

abstract class VideoState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoStateInitial extends VideoState {}

class VideoStateRecorded extends VideoState {}

class VideoStateUploading extends VideoState {
  final int sectionId;

  VideoStateUploading({@required this.sectionId});
}

class VideoStateSuccess extends VideoState {}

class VideoStateFailure extends VideoState {
  final String errorMsg;

  VideoStateFailure({this.errorMsg});
}

class VideoStateCancel extends VideoState {}
