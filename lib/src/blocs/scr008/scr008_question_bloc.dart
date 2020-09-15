/*
 * File: scr008_question_bloc.dart
 * Project: CVideo
 * File Created: Wednesday, 8th July 2020 4:37 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:08 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/scr008/scr008_bloc_barrel.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final SCR008Repository scr008repository;

  QuestionBloc({@required this.scr008repository});

  @override
  QuestionState get initialState => QuestionInitial();

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is QuestionFetched) {
      yield* _mapQuestionFetchedToState(event.setId);
    }
  }

  Stream<QuestionState> _mapQuestionFetchedToState(int setId) async* {
    try {
      yield QuestionLoading();
      final  jsonQuestions = await scr008repository.getQuestions(setId);

      yield QuestionSuccess(jsonQuestions: jsonQuestions);
    } catch (e) {
      yield QuestionFailure();
    }
  }
}
