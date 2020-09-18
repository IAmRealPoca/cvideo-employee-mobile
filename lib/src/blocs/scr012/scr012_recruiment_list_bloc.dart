/*
 * File: scr012_recruiment_list_bloc.dart
 * Project: CVideo
 * File Created: Tuesday, 30th June 2020 6:44:23 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 30th June 2020 6:50:57 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitmentListBloc
    extends Bloc<RecruitmentListEvent, RecruitmentListState> {
  final PostRepository postRepository;

  RecruitmentListBloc({this.postRepository}) : assert(postRepository != null);
  @override
  void onTransition(
      Transition<RecruitmentListEvent, RecruitmentListState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  RecruitmentListState get initialState => RecruitmentListFetchInitial();

  @override
  Stream<RecruitmentListState> mapEventToState(
      RecruitmentListEvent event) async* {
    List<RecruitmentPost> recruitmentPostList;
    final currentState = state;
    String _url;
    int position;

    if (event is RecruitmentListFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is RecruitmentListFetchInitial) {
          if (event.url.contains("?")) {
            _url = event.url + "&offset=0&limit=6";
          } else {
            _url = event.url + "?offset=0&limit=6";
          }
          recruitmentPostList =
              await postRepository.fetchRecruitmentPostList(_url);
          yield RecruitmentListFetchedSuccess(
              recruitmentPostList: recruitmentPostList,
              hasReachedMax: recruitmentPostList.length >= 6 ? false : true);
          return;
        }
        if (currentState is RecruitmentListFetchedSuccess) {
          position = currentState.recruitmentPostList.length;

          if (event.url.contains("?")) {
            _url = event.url + "&offset=$position&limit=6";
          } else {
            _url = event.url + "?offset=$position&limit=6";
          }
          recruitmentPostList =
              await postRepository.fetchRecruitmentPostList(_url);

          yield recruitmentPostList.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : RecruitmentListFetchedSuccess(
                  recruitmentPostList:
                      currentState.recruitmentPostList + recruitmentPostList,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield RecruitmentListFetchedFailure();
      }
    }
  }

  bool _hasReachedMax(RecruitmentListState state) =>
      state is RecruitmentListFetchedSuccess && state.hasReachedMax;
}
