import 'package:cvideo_mobile/src/models/scr003/video.dart';
import 'package:equatable/equatable.dart';

import 'field.dart';

class Session extends Equatable {
  final int sessionId;
  final String sessionTitle;
  final String sessionText;
  final List<Field> sessionField;
  final List<Video> sessionVideo;
  final String icon;
  final int sectionTypeId;
  int displayOrder;

  Session(
      {this.sessionText,
      this.sessionField,
      this.sessionId,
      this.sessionTitle,
      this.icon,
      this.sectionTypeId,
      this.sessionVideo,
      this.displayOrder});

  factory Session.fromJson(Map<String, dynamic> json) {
    //map field to list
    List<Field> fields = [];
    var list = json['fields'] as List;
    if (list != null) {
      fields = list.map((i) => Field.fromJson(i)).toList();
    }

    List<Video> videos = [];
    var listVideo = json['videos'] as List;
    if (listVideo != null) {
      videos = listVideo.map((e) => Video.fromJson(e)).toList();
    }

    return Session(
      sessionId: json['sectionId'],
      sessionTitle: json['title'] == null ? "" : json['title'].toString(),
      sessionText: json['text'] == null ? "" : json['text'].toString(),
      icon: json['icon'] == null ? "" : json['icon'].toString(),
      sessionField: fields,
      sectionTypeId: json['sectionTypeId'],
      sessionVideo: videos,
    );
  }

  @override
  List<Object> get props => [];
}
