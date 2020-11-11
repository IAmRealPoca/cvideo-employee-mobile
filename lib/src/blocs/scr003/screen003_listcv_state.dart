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
  final List<SkillsDetail> listSkills;

  GetListCVSuccess({this.listResume, this.listSkills});

  GetListCVSuccess copyWith(
      {List<Resume> listResume, List<Skills> listSkills}) {
    return GetListCVSuccess(
        listResume: listResume ?? this.listResume,
        listSkills: listSkills ?? this.listSkills);
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
  final List<SkillsDetail> listSkills;

  DeleteCVSuccess({this.listResume, this.result, this.listSkills});

  DeleteCVSuccess copyWith(
      {String result, List<Resume> listResume, List<Skills> listSkills}) {
    return DeleteCVSuccess(
        result: result ?? this.result,
        listResume: listResume ?? this.listResume,
        listSkills: listSkills ?? this.listSkills);
  }

  @override
  String toString() => 'Delete CV success';
}

class CreateCVSuccessState extends LoadListCVState {
  final List<Resume> listResume;
  final List<Skills> listSkills;
  final int cvId;
  final String title;

  CreateCVSuccessState(
      {this.listResume, this.listSkills, this.cvId, this.title});

  CreateCVSuccessState copyWith(
      {List<Resume> listResume, List<Skills> listSkills, int cvId}) {
    return CreateCVSuccessState(
        title: title ?? this.title,
        cvId: cvId ?? this.cvId,
        listResume: listResume ?? this.listResume,
        listSkills: listSkills ?? this.listSkills);
  }

  @override
  String toString() => 'Create CV success';
}
