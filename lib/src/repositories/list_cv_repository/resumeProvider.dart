import 'dart:convert';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';

class ResumeProvider {
  final successCode = 200;
  AppStorage storage = AppStorage.instance;

  Future<List<Resume>> fetchResumeList() async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    List<Resume> listResume;
    final response = await AppHttpClient.get("/employees/current-employee/cvs",
        headers: {"Authorization": "bearer $token"});
    if (successCode != response.statusCode) {
      throw Exception("Failed to loading!");
    }
    final List<dynamic> dataJson = json.decode(utf8.decode(response.bodyBytes));

    listResume = dataJson.map((e) => Resume.fromJson(e)).toList();
    return listResume;
  }

  Future<List<SkillsDetail>> fetchSkillList(String lang) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    List<SkillsDetail> listSkill;
    final response = await AppHttpClient.get("/skills?lang=" + lang,
        headers: {"Authorization": "bearer $token"});
    if (successCode != response.statusCode) {
      throw Exception("Failed to loading!");
    }
    final List<dynamic> dataJson = json.decode(utf8.decode(response.bodyBytes));

    listSkill = dataJson.map((e) => SkillsDetail.fromJson(e)).toList();
    return listSkill;
  }

  Future<String> deleteCv(String cvId) async {
    String result = "";
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.delete("/cvs/" + cvId,
        headers: {"Authorization": "bearer $token"});
    if (response.statusCode == 204) {
      result = "Delete CV success";
    } else {
      throw Exception('Failed to delete cv');
    }
    return result;
  }

  Future<Resume> viewDetailCV(String cvId) async {
    Resume resume;
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.get("/url/" + cvId,
        headers: {"Authorization": "bearer $token"});
    if (response.statusCode == 200) {
      resume = Resume.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to find cv');
    }
    return resume;
  }

  Future<String> addNewCV(String title, int skillId) async {
    String token = await storage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.post("/cvs",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: jsonEncode({"title": title, "skillId": skillId}));
    if (201 != response.statusCode) {
      throw Exception("Failed to adding!");
    } else {
      result = "success";
    }
    return result;
  }
}
