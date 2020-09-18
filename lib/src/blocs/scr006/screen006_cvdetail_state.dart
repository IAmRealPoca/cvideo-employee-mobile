import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/models/scr003/cvdetail.dart';
import 'package:cvideo_mobile/src/models/scr003/session.dart';
import 'package:cvideo_mobile/src/models/scr003/sessionType.dart';
import 'package:equatable/equatable.dart';

abstract class LoadCVDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCVDetailUtinity extends LoadCVDetailState {}

class GetCVDetailLoading extends LoadCVDetailState {}

class GetCVDetailSuccess extends LoadCVDetailState {
  final CVDetail cvDetail;
  final List<Session> listSession;
  final Employee employee;

  GetCVDetailSuccess({this.listSession, this.employee, this.cvDetail});

  GetCVDetailSuccess copyWith({
    CVDetail cvDetail,
    List<Session> listSession,
    Employee employee,
  }) {
    return GetCVDetailSuccess(
        listSession: listSession ?? this.listSession,
        employee: employee ?? this.employee,
        cvDetail: cvDetail ?? this.cvDetail);
  }

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Detail CV load success';
}

class GetCVDetailFailed extends LoadCVDetailState {
  @override
  String toString() => 'Load CV Detail failed';
}

class DeleteDetailSuccess extends LoadCVDetailState {
  final CVDetail cvDetail;
  final List<Session> listSession;
  final Employee employee;
  final String result;

  DeleteDetailSuccess(
      {this.listSession, this.result, this.cvDetail, this.employee});

  DeleteDetailSuccess copyWith({
    String result,
    List<Session> listSession,
    Employee employee,
    CVDetail cvDetail,
  }) {
    return DeleteDetailSuccess(
        result: result ?? this.result,
        listSession: listSession ?? this.listSession,
        employee: employee ?? this.employee,
        cvDetail: cvDetail ?? this.cvDetail);
  }

  @override
  String toString() => 'Delete session success';
}

class UpdateTextSuccess extends LoadCVDetailState {
  final CVDetail cvDetail;
  final List<Session> listSession;
  final Employee employee;
  final String result;

  UpdateTextSuccess(
      {this.listSession, this.result, this.cvDetail, this.employee});

  UpdateTextSuccess copyWith({
    String result,
    List<Session> listSession,
    Employee employee,
    CVDetail cvDetail,
  }) {
    return UpdateTextSuccess(
        result: result ?? this.result,
        listSession: listSession ?? this.listSession,
        employee: employee ?? this.employee,
        cvDetail: cvDetail ?? this.cvDetail);
  }

  @override
  String toString() => 'Delete session success';
}

class UpdateTextFailed extends LoadCVDetailState {
  @override
  String toString() => 'Delete failed';
}

class AddFieldSuccess extends LoadCVDetailState {
  final CVDetail cvDetail;
  final List<Session> listSession;
  final Employee employee;
  final String result;

  AddFieldSuccess(
      {this.listSession, this.result, this.cvDetail, this.employee});

  AddFieldSuccess copyWith({
    String result,
    List<Session> listSession,
    Employee employee,
    CVDetail cvDetail,
  }) {
    return AddFieldSuccess(
        result: result ?? this.result,
        listSession: listSession ?? this.listSession,
        employee: employee ?? this.employee,
        cvDetail: cvDetail ?? this.cvDetail);
  }

  @override
  String toString() => 'Add field success';
}

class AddFieldFailed extends LoadCVDetailState {
  @override
  String toString() => 'Add field failed';
}

class FetchSectionTypeSuccess extends LoadCVDetailState {
  final List<SessionType> listSessionType;

  FetchSectionTypeSuccess(this.listSessionType);
}

class FetchSectionTypeEmpty extends LoadCVDetailState {
  @override
  String toString() => "List section type  is empty";
}
