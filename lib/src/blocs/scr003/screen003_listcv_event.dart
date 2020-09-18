import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoadListCVEvent extends Equatable {
  const LoadListCVEvent();

  @override
  List<Object> get props => [];
}

class FetchListCVEvent extends LoadListCVEvent {
  final String lang;

  FetchListCVEvent({this.lang});
}

class FetchRefresh extends LoadListCVEvent {
  final String lang;
  final List<Resume> listResume;

  const FetchRefresh({@required this.listResume, this.lang});
}

class DeleteCVEvent extends LoadListCVEvent {
  final String cvId;
  final String lang;

  const DeleteCVEvent({@required this.cvId, this.lang});
}

class AddNewCVEvent extends LoadListCVEvent {
  final String cvTitle;
  final int majorId;
  final String lang;

  const AddNewCVEvent({@required this.cvTitle, this.majorId, this.lang});
}
