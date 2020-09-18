import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen006_cvdetail_event.dart';
import 'screen006_cvdetail_state.dart';

class LoadCVDetailBloc extends Bloc<LoadCVDetailEvent, LoadCVDetailState> {
  final DetailCVRepository repository;

  LoadCVDetailBloc({this.repository}) : assert(repository != null);

  @override
  LoadCVDetailState get initialState => GetCVDetailUtinity();

  @override
  Stream<LoadCVDetailState> mapEventToState(LoadCVDetailEvent event) async* {
    final currentState = state;
    if (event is FetchCVDetail) {
      try {
        if (currentState is GetCVDetailUtinity) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;

          yield GetCVDetailSuccess(
              listSession: listSession, employee: employee, cvDetail: cvDetail);
          return;
        }
        if (currentState is GetCVDetailSuccess) {
          yield GetCVDetailLoading();
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield listSession.isEmpty
              ? currentState.copyWith()
              : GetCVDetailSuccess(
                  listSession: listSession, employee: employee);
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is FetchRefreshCVDtail) {
      try {
        yield GetCVDetailLoading();
        final cvDetail = await repository.fetchCVDetail(event.lang);
        final employee = cvDetail.employee;
        final listSession = cvDetail.sessions;
        yield GetCVDetailSuccess(
            listSession: listSession, employee: employee, cvDetail: cvDetail);
        return;
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is DeleteSessionEvent) {
      try {
        yield GetCVDetailLoading();
        final result =
            await repository.deleteSession(event.sessionId, event.cvId);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield DeleteDetailSuccess(
              cvDetail: cvDetail,
              employee: employee,
              listSession: listSession,
              result: result);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is DeleteFieldEvent) {
      try {
        yield GetCVDetailLoading();
        final result = await repository.deleteField(
            event.sessionId, event.cvId, event.fieldId);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield DeleteDetailSuccess(
              cvDetail: cvDetail, employee: employee, listSession: listSession);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }

    if (event is DeleteVideoEvent) {
      try {
        yield GetCVDetailLoading();
        final result = await repository.deleteVideo(
            event.sessionId, event.cvId, event.videoId);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield DeleteDetailSuccess(
              cvDetail: cvDetail, employee: employee, listSession: listSession);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }

    if (event is UpdateSessionEvent) {
      try {
        yield GetCVDetailLoading();
        final result =
            await repository.updateSession(event.session, event.cvId);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield UpdateTextSuccess(
              cvDetail: cvDetail, employee: employee, listSession: listSession);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is UpdateFieldEvent) {
      try {
        yield GetCVDetailLoading();
        final result = await repository.updateField(
            event.sessionId, event.cvId, event.field);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield UpdateTextSuccess(
              cvDetail: cvDetail, employee: employee, listSession: listSession);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is AddFieldEvent) {
      try {
        yield GetCVDetailLoading();
        final result =
            await repository.addField(event.sessionId, event.cvId, event.field);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield AddFieldSuccess(
              cvDetail: cvDetail,
              employee: employee,
              listSession: listSession,
              result: result);
        } else {
          yield AddFieldFailed();
        }
      } catch (_) {
        yield AddFieldFailed();
      }
    }
    if (event is FetchSectionTypeEvent) {
      try {
        yield GetCVDetailLoading();
        final cvDetail = await repository.fetchCVDetail(event.lang);
        final listSessionType = await repository.fetchSessionType(event.lang);
        if (listSessionType.length > 0) {
          for (var session in cvDetail.sessions) {
            for (int i = 0; i < listSessionType.length; i++) {
              if (session.sectionTypeId == listSessionType[i].typeId) {
                listSessionType.removeAt(i);
              }
            }
          }
          yield FetchSectionTypeSuccess(listSessionType);
        } else {
          yield FetchSectionTypeEmpty();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is AddSessionEvent) {
      try {
        yield GetCVDetailLoading();
        final result = await repository.addSession(
            event.typeId, event.session, event.cvId);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield GetCVDetailSuccess(
              listSession: listSession, employee: employee, cvDetail: cvDetail);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
    if (event is UpdateCVEvent) {
      try {
        yield GetCVDetailLoading();
        final result = await repository.updateCV(event.cvDetail);
        if (result.length > 0) {
          final cvDetail = await repository.fetchCVDetail(event.lang);
          final employee = cvDetail.employee;
          final listSession = cvDetail.sessions;
          yield UpdateTextSuccess(
              cvDetail: cvDetail, employee: employee, listSession: listSession);
        } else {
          yield GetCVDetailFailed();
        }
      } catch (_) {
        yield GetCVDetailFailed();
      }
    }
  }
}
