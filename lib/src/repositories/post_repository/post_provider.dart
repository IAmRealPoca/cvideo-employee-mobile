/*
 * File: home_provider.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 8:07:55 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 12th June 2020 9:24:53 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'dart:async';
import 'dart:convert';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';

class PostProvider {
  final successCode = 200;

  // Fetch data for title and url to get list post recruitment below
  Future<List<SectionInfo>> fetchSectionInfo(String lang) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    List<SectionInfo> sectionInfoList;
    final response = await AppHttpClient.get("/newsfeed/sections?lang=$lang",
        headers: {"Authorization": "bearer $token"});
    if (successCode != response.statusCode) {
      throw Exception("Failed to loading!");
    }
    final List<dynamic> dataJson = json.decode(utf8.decode(response.bodyBytes));
    sectionInfoList = dataJson.map((e) => SectionInfo.fromJson(e)).toList();
    return sectionInfoList;
  }

  // Fetch list recruitment post according to url
  Future<List<RecruitmentPost>> fetchRecruitmentPostList(String url) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    List<RecruitmentPost> recruitmentLists;
    final response = await AppHttpClient.get("$url",
        headers: {"Authorization": "bearer $token"}).then((response) {
      print(response.statusCode);
      if (response.statusCode == successCode) {
        List<dynamic> dataJson = json.decode(utf8.decode(response.bodyBytes));
        recruitmentLists =
            dataJson.map((e) => RecruitmentPost.fromJson(e)).toList();
      } else {
        throw Exception("Failed to loading!");
      }
      return recruitmentLists;
    }).catchError((error) {
      print("Errorrrrrrr : $error");
    });
    return recruitmentLists;
  }

  // Fetch list recruitment post detail according to postId
  Future<RecruitmentPost> fetchRecruitmentPostDetail(int postId) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    RecruitmentPost recruitmentPostDetail;
    final response = await AppHttpClient.get("/recruitment-posts/$postId",
        headers: {"Authorization": "bearer $token"}).then((response) {
      if (successCode != response.statusCode) {
        throw Exception("Failed to loading!");
      }
      final dataJson = json.decode(utf8.decode(response.bodyBytes));
      recruitmentPostDetail = RecruitmentPost.fromJson(dataJson);
      return recruitmentPostDetail;
    }).catchError((error) {
      print("Errorrrrrrr : $error");
    });
    return recruitmentPostDetail;
  }
}
