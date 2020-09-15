import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class LoadListCVState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListCVUnitity extends LoadListCVState {}

class GetListCVLoading extends LoadListCVState {}

class GetListCVSuccess extends LoadListCVState {
  final List<Resume> listResume;
  final List<MajorDetail> listMajor;

  GetListCVSuccess({this.listResume, this.listMajor});

  GetListCVSuccess copyWith({List<Resume> listResume, List<Major> listMajor}) {
    return GetListCVSuccess(
        listResume: listResume ?? this.listResume,
        listMajor: listMajor ?? this.listMajor);
  }

  @override
  List<Object> get props => [listResume];

  @override
  String toString() => 'List CV load success';
}

class GetListCVFailed extends LoadListCVState {
  @override
  String toString() => 'Load list CV falied';
}

class GetListCVRefresh extends LoadListCVState {
  @override
  String toString() => 'Refresh list CV';
}

class DeleteCVSuccess extends LoadListCVState {
  final List<Resume> listResume;
  final String result;
  final List<MajorDetail> listMajor;

  DeleteCVSuccess({this.listResume, this.result, this.listMajor});

  DeleteCVSuccess copyWith(
      {String result, List<Resume> listResume, List<MajorDetail> listMajor}) {
    return DeleteCVSuccess(
        result: result ?? this.result,
        listResume: listResume ?? this.listResume,
        listMajor: listMajor ?? this.listMajor);
  }

  @override
  String toString() => 'Delete CV success';
}

class CreateCVSuccessState extends LoadListCVState {
  final List<Resume> listResume;
  final List<Major> listMajor;
  final int cvId;
  final String title;

  CreateCVSuccessState(
      {this.listResume, this.listMajor, this.cvId, this.title});

  CreateCVSuccessState copyWith(
      {List<Resume> listResume, List<Major> listMajor, int cvId}) {
    return CreateCVSuccessState(
        title: title ?? this.title,
        cvId: cvId ?? this.cvId,
        listResume: listResume ?? this.listResume,
        listMajor: listMajor ?? this.listMajor);
  }

  @override
  String toString() => 'Create CV success';
}
