/*
 * File: scr008_reposiotry.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 10:56 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:46 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/models/scr008/scr008_models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

class SCR008Repository {
  final SCR008Provider scr008provider;

  SCR008Repository({@required this.scr008provider})
      : assert(scr008provider != null);

  Future<List<QuestionSet>> getQuestionSets({@required int sectionId}) {
    return scr008provider.fetchQuestionSets(sectionId: sectionId);
  }

  Future<List<VideoStyle>> getVideoStyles() {
    return scr008provider.fetchVideoStyles();
  }

  Future<String> getQuestions(int setId) {
    return scr008provider.fetchQuestions(setId);
  }

  Future<void> postVideoInfo({VideoInfo videoInfo}) {
    return scr008provider.addNewVideoInfo(videoInfo);
  }
}
