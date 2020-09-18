import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/models/scr003/cvdetail.dart';
import 'package:cvideo_mobile/src/models/scr003/field.dart';
import 'package:cvideo_mobile/src/models/scr003/session.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoadCVDetailEvent extends Equatable {
  const LoadCVDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchCVDetail extends LoadCVDetailEvent {
  final String lang;

  FetchCVDetail({@required this.lang});
}

class FetchRefreshCVDtail extends LoadCVDetailEvent {
  final String lang;
  final CVDetail cvDetail;
  final List<Session> listSession;
  final Employee employee;

  FetchRefreshCVDtail(
      {this.listSession, this.employee, this.cvDetail, this.lang});
}

class DeleteSessionEvent extends LoadCVDetailEvent {
  final int cvId;
  final int sessionId;
  final String lang;

  const DeleteSessionEvent({@required this.cvId, this.sessionId, this.lang});
}

class DeleteFieldEvent extends LoadCVDetailEvent {
  final int cvId;
  final int sessionId;
  final int fieldId;
  final String lang;

  const DeleteFieldEvent(
      {@required this.cvId, this.sessionId, this.fieldId, this.lang});
}

class DeleteVideoEvent extends LoadCVDetailEvent {
  final int cvId;
  final int sessionId;
  final int videoId;
  final String lang;

  const DeleteVideoEvent(
      {@required this.cvId, this.sessionId, this.videoId, this.lang});
}

class UpdateSessionEvent extends LoadCVDetailEvent {
  final Session session;
  final int cvId;
  final String lang;

  UpdateSessionEvent(this.session, this.cvId, this.lang);
}

class UpdateCVEvent extends LoadCVDetailEvent {
  final CVDetail cvDetail;
  final String lang;

  UpdateCVEvent(this.cvDetail, this.lang);
}

class UpdateFieldEvent extends LoadCVDetailEvent {
  final int sessionId;
  final int cvId;
  final Field field;
  final String lang;

  UpdateFieldEvent(this.sessionId, this.cvId, this.field, this.lang);
}

class AddFieldEvent extends LoadCVDetailEvent {
  final Field field;
  final int sessionId;
  final int cvId;
  final String lang;

  AddFieldEvent(this.field, this.sessionId, this.cvId, this.lang);
}

class FetchSectionTypeEvent extends LoadCVDetailEvent {
  final String lang;

  FetchSectionTypeEvent({this.lang});
}

class AddSessionEvent extends LoadCVDetailEvent {
  final int typeId;
  final Session session;
  final int cvId;
  final String lang;

  AddSessionEvent(this.typeId, this.session, this.cvId, this.lang);
}
