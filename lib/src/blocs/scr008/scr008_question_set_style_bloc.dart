/*
 * File: scr008_question_set_style_bloc.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 10:38 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:48 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */

import 'package:cvideo_mobile/src/blocs/scr008/scr008_bloc_barrel.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class QuestionSetStyleBloc
    extends Bloc<QuestionSetStyleEvent, QuestionSetStyleState> {
  final SCR008Repository scr008repository;

  QuestionSetStyleBloc({@required this.scr008repository});

  @override
  QuestionSetStyleState get initialState => QuestionSetStyleInitial();

  @override
  Stream<QuestionSetStyleState> mapEventToState(
      QuestionSetStyleEvent event) async* {
    if (event is QuestionSetStyleFetched) {
      yield* _mapDropdownListFetchedToState(sectionId: event.sectionId);
    }
  }

  Stream<QuestionSetStyleState> _mapDropdownListFetchedToState({
    int sectionId,
  }) async* {
    try {
      final listQuestionSets =
          await scr008repository.getQuestionSets(sectionId: sectionId);
      final listVideoSets = await scr008repository.getVideoStyles();
      yield QuestionSetStyleSuccess(
        listQuestionSet: listQuestionSets,
        listStyle: listVideoSets,
      );
    } catch (e) {
      print(e);
      yield QuestionSetStyleFailure();
    }
  }
}
