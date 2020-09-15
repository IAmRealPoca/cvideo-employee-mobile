/*
 * File: cv_provider.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 8:53:29 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 24th June 2020 8:54:44 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'dart:async';
import 'dart:convert';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';

class CVProvider {
  final successCode = 200;
  final successAddCode = 201;
  Future<List<CV>> fetchListCVs(int majorId) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    List<CV> cvLists;
    final response = await AppHttpClient.get(
        "/employees/current-employee/cvs?majorId=$majorId",
        headers: {"Authorization": "bearer $token"});
    if (successCode != response.statusCode) {
      throw Exception("Failed to loading!");
    }
    final List<dynamic> dataJson = jsonDecode(utf8.decode(response.bodyBytes));
    cvLists = dataJson.map((e) => CV.fromJson(e)).toList();
    return cvLists;
  }

  Future<String> applyCv(int postId, int cvId) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    final response = await AppHttpClient.post(
        "/recruitment-posts/$postId/applied-cvs",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: jsonEncode({"cvId": cvId}));
    if (successAddCode != response.statusCode) {
      throw Exception("Failed to adding!");
    }
    return "success";
  }
}
