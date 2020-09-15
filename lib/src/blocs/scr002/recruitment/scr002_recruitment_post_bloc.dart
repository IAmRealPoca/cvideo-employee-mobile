/*
 * File: scr002_recruitment_post_bloc.dart
 * Project: CVideo
 * File Created: Monday, 29th June 2020 3:35:42 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 29th June 2020 4:01:18 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitmentPostBloc
    extends Bloc<RecruitmentPostEvent, RecruitmentPostState> {
  final PostRepository postRepository;
  RecruitmentPostBloc({this.postRepository}) : assert(postRepository != null);

  @override
  void onTransition(
      Transition<RecruitmentPostEvent, RecruitmentPostState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  RecruitmentPostState get initialState => RecruitmentPostFetchInitial();

  @override
  Stream<RecruitmentPostState> mapEventToState(
      RecruitmentPostEvent event) async* {
    List<RecruitmentPost> recruitmentPostList;
    yield RecruitmentPostFetching();

    if (event is RecruitmentPostFetched) {
      try {
        recruitmentPostList =
            await postRepository.fetchRecruitmentPostList(event.url);
        yield RecruitmentPostFetchedSuccess(
            recruitmentPostList: recruitmentPostList);
      } catch (_) {
        yield RecruitmentPostFetchedFailure();
      }
    }
  }
}
