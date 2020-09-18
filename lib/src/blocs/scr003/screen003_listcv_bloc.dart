import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs.dart';

class LoadListCVBloc extends Bloc<LoadListCVEvent, LoadListCVState> {
  final ResumeRepository repository;

  LoadListCVBloc({this.repository}) : assert(repository != null);

  @override
  LoadListCVState get initialState => GetListCVUnitity();

  @override
  Stream<LoadListCVState> mapEventToState(LoadListCVEvent event) async* {
    final currentState = state;
    if (event is FetchListCVEvent) {
      try {
        if (currentState is GetListCVUnitity) {
          final listResume = await repository.fetchResumeList();
          final listMajor = await repository.fetchMajorList(event.lang);
          yield GetListCVSuccess(listResume: listResume, listMajor: listMajor);
          return;
        }
        if (currentState is GetListCVSuccess) {
          yield GetListCVLoading();
          final listResume = await repository.fetchResumeList();
          final listMajor = await repository.fetchMajorList(event.lang);
          yield listResume.isEmpty
              ? currentState.copyWith()
              : GetListCVSuccess(listResume: listResume, listMajor: listMajor);
        }
      } catch (_) {
        yield GetListCVFailed();
      }
    }
    if (event is FetchRefresh) {
      try {
        final listResume = await repository.fetchResumeList();
        final listMajor = await repository.fetchMajorList(event.lang);
        yield GetListCVSuccess(listResume: listResume, listMajor: listMajor);
      } catch (_) {
        yield GetListCVFailed();
      }
    }
    if (event is DeleteCVEvent) {
      try {
        yield GetListCVLoading();
        final result = await repository.deleteCV(event.cvId);
        if (result.length > 0) {
          final listResume = await repository.fetchResumeList();
          final listMajor = await repository.fetchMajorList(event.lang);
          yield DeleteCVSuccess(
              result: result, listResume: listResume, listMajor: listMajor);
        } else {
          yield GetListCVFailed();
        }
      } catch (_) {
        yield GetListCVFailed();
      }
    }
    if (event is AddNewCVEvent) {
      try {
        yield GetListCVLoading();
        final result = await repository.addNewCV(event.cvTitle, event.majorId);
        if (result.length > 0) {
          final listResume = await repository.fetchResumeList();
          final listMajor = await repository.fetchMajorList(event.lang);
          yield GetListCVSuccess(listResume: listResume, listMajor: listMajor);
        } else {
          yield GetListCVFailed();
        }
      } catch (_) {
        yield GetListCVFailed();
      }
    }
  }
}
