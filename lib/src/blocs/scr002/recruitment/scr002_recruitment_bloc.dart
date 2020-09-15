/*
 * File: scr002_recruitment_bloc.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 9:11:30 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 12:28:42 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/scr002/scr002_models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitmentBloc extends Bloc<RecruitmentEvent, RecruitmentState> {
  final PostRepository postRepository;
  RecruitmentBloc({this.postRepository}) : assert(postRepository != null);

  @override
  void onTransition(Transition<RecruitmentEvent, RecruitmentState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  RecruitmentState get initialState => UninitialisedRecruitmentState();

  @override
  Stream<RecruitmentState> mapEventToState(RecruitmentEvent event) async* {
    yield RecruitmentFetching();
    List<SectionInfo> sectionInfoList;
    if (event is RecruitmentFetched) {
      try {
        sectionInfoList = await postRepository.fetchSectionInfo(event.lang);
        if (sectionInfoList.isEmpty) {
          yield RecruitmentFetchFailure();
        } else {
          yield RecruitmentFetchSuccess(sectionInfoList: sectionInfoList);
        }
      } catch (_) {
        yield RecruitmentFetchFailure();
      }
    }
  }
}
