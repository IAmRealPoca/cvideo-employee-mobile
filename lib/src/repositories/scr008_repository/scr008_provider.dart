/*
 * File: scr008_provider.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 11:00 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 11:46 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */

import 'dart:convert';

import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/scr008/scr008_models.dart';
import 'package:meta/meta.dart';

class SCR008Provider {
  Future<List<QuestionSet>> fetchQuestionSets({@required int sectionId}) async {
    final response =
        await AppHttpClient.get("/question-sets?SectionTypeId=$sectionId");
    if (response.statusCode != 200) {
      throw Exception("Error getting list of question set");
    }

    List<dynamic> jsonQuestionSet = jsonDecode(response.body);

    return jsonQuestionSet.map((e) => QuestionSet.fromJson(e)).toList();
  }

  Future<List<VideoStyle>> fetchVideoStyles() async {
    final response = await AppHttpClient.get("/videos/styles");
    if (response.statusCode != 200) {
      throw Exception("Error getting list of video style");
    }

    List<dynamic> jsonVideoStyle = jsonDecode(response.body);

    return jsonVideoStyle.map((e) => VideoStyle.fromJson(e)).toList();
  }

  Future<String> fetchQuestions(int setId) async {
    final response = await AppHttpClient.get("/question-sets/$setId");
    if (response.statusCode != 200) {
      throw Exception("Error getting question set");
    }
    dynamic jsonRaw = jsonDecode(response.body);

    if ((jsonRaw['questions'] as List).length == 0) {
      throw Exception("There's no question in this setId");
    }

    return jsonEncode(jsonRaw['questions']);
  }

  Future<void> addNewVideoInfo(VideoInfo videoInfo) async {
    String apiToken = await AppStorage.instance.readSecureApiToken();
    final response = await AppHttpClient.post(
      "/cvs/${videoInfo.cvId}/sections/${videoInfo.sectionId}/videos",
      body: jsonEncode(videoInfo.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "bearer $apiToken"
      },
    );

    print("addNewVideoInfo: ${response.statusCode}");
    print("body: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception("Error while posting video's information to server");
    }
  }
}
