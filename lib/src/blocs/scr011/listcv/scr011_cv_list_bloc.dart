/*
 * File: scr011_cv_bloc.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 9:03:12 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Thursday, 25th June 2020 4:37:39 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CVListBloc extends Bloc<CVListEvent, CVListState> {
  final CVRepository cvRepository;
  CVListBloc({this.cvRepository}) : assert(cvRepository != null);

  @override
  void onTransition(Transition<CVListEvent, CVListState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  CVListState get initialState => CVListInitial();

  @override
  Stream<CVListState> mapEventToState(CVListEvent event) async* {
    List<CV> cvLists;
    yield CVListFetching();

    if (event is CVListFetched) {
      try {
        if (event is CVListFetched) {
          cvLists = await cvRepository.fetchListCVs(event.majorId);
          yield CVListFetchedSucess(cvlists: cvLists);
        }
      } catch (_) {
        yield CVListFetchedFailure();
      }
    }
  }
}
