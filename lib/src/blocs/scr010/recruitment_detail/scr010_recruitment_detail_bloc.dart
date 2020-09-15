/*
 * File: scr010_recruitment_detail_bloc.dart
 * Project: CVideo
 * File Created: Monday, 22nd June 2020 4:39:48 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 22nd June 2020 5:06:13 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitmentDetailBloc
    extends Bloc<RecruitmentDetailEvent, RecruitmentDetailState> {
  final PostRepository postRepository;
  RecruitmentDetailBloc({this.postRepository}) : assert(postRepository != null);
  @override
  void onTransition(
      Transition<RecruitmentDetailEvent, RecruitmentDetailState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  RecruitmentDetailState get initialState => RecruitmentDetailFetchInitial();

  @override
  Stream<RecruitmentDetailState> mapEventToState(
      RecruitmentDetailEvent event) async* {
    if (event is RecruitmentDetailRequest) {
      try {
        final RecruitmentPost recruitmentPost =
            await postRepository.fetchRecruitmentPostDetail(event.postId);
        yield RecruitmentDetailFetchedSuccess(recruitmentPost: recruitmentPost);
      } catch (_) {
        yield RecruitmentDetailFetchedFailure();
      }
    }
  }
  
}
