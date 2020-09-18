/*
 * File: video_style.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 11:31 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:48 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VideoStyle extends Equatable{
  final int id;
  final String name;

  VideoStyle({
    @required this.id,
    @required this.name,
  });

   @override
  List<Object> get props => [this.id, this.name];

  static VideoStyle fromJson(dynamic json) {
    return VideoStyle(
      id: json['styleId'] as int,
      name: json['styleName'] as String,
    );
  }

 
}
