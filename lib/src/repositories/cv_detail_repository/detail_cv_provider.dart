import 'dart:convert';

import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';

class DetailCVProvider {
  final successCode = 200;
  AppStorage storage = AppStorage.instance;

  Future<CVDetail> fetchCVDetail(String cvId, String lang) async {
    CVDetail cvDetail;
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.get("/cvs/" + cvId + "?lang=" + lang,
        headers: {"Authorization": "bearer $token "});
    if (response.statusCode == successCode) {
      cvDetail = CVDetail.fromJson(jsonDecode(response.body));
      final listType = await fetchAllSessionType(lang);
      for (var section in cvDetail.sessions) {
        for (var type in listType) {
          if (section.sectionTypeId == type.typeId) {
            section.displayOrder = type.displayOrder;
          }
        }
      }
    } else {
      throw Exception('Failed to load cv');
    }

    return cvDetail;
  }

  Future<String> deleteSession(int sessionId, int cvId) async {
    String result = "";
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.delete(
        "/cvs/$cvId/sections/$sessionId",
        headers: {"Authorization": "bearer $token "});
    if (response.statusCode == 204) {
      result = "Delete session success";
    } else {
      throw Exception('Failed to delete session');
    }
    return result;
  }

  Future<String> deleteVideo(int sessionId, int cvId, int videoId) async {
    String result = "";
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.delete(
        "/cvs/$cvId/sections/$sessionId/videos/$videoId",
        headers: {"Authorization": "bearer $token "});
    if (response.statusCode == 204) {
      result = "Delete session success";
    } else {
      throw Exception('Failed to delete session');
    }
    return result;
  }

  Future<String> deleteField(int sessionId, int cvId, int fieldId) async {
    String result = "";
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.delete(
        "/cvs/$cvId/sections/$sessionId/fields/$fieldId",
        headers: {"Authorization": "bearer $token "});
    if (response.statusCode == 204) {
      result = "Delete session success";
    } else {
      throw Exception('Failed to delete session');
    }
    return result;
  }

  Future<String> updateSession(Session sesison, int cvId) async {
    String token = await storage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.put(
      "/cvs/$cvId/sections/${sesison.sessionId}",
      headers: {
        "Authorization": "bearer $token",
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': sesison.sessionTitle,
        'text': sesison.sessionText,
        'sectionId': sesison.sessionId,
        'cvId': cvId,
      }),
    );
    if (response.statusCode == 204) {
      result = "Update session title successful";
    } else {
      throw Exception("Failed to update!");
    }
    return result;
  }

  Future<String> updateField(int sessionId, Field field, int cvId) async {
    String token = await storage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.put(
      "/cvs/$cvId/sections/$sessionId/fields/${field.fieldId}",
      headers: {
        "Authorization": "bearer $token",
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "fieldId": field.fieldId,
        "name": field.fieldName,
        "text": field.fieldText
      }),
    );
    if (response.statusCode == 204) {
      result = "Update field title successful";
    } else {
      throw Exception("Failed to update!");
    }
    return result;
  }

  Future<String> createField(Field field, int cvId, int sessionId) async {
    String token = await storage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.post(
        "/cvs/$cvId/sections/$sessionId/fields",
        headers: {
          "Authorization": "bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"name": field.fieldName, "text": field.fieldText}));
    if (response.statusCode == 201) {
      result = "Add field successful";
    } else {
      throw Exception("Failed to add field!");
    }
    return result;
  }

  Future<List<SessionType>> fetchAllSessionType(String lang) async {
    List<SessionType> listSessionType;
    String token = await storage.readSecureApiToken();
    final response = await AppHttpClient.get("/cvs/section-types?lang=$lang",
        headers: {"Authorization": "bearer $token"});
    if (successCode != response.statusCode) {
      throw Exception("Failed to loading!");
    }
    final List<dynamic> dataJson = json.decode(utf8.decode(response.bodyBytes));

    listSessionType = dataJson.map((e) => SessionType.fromJson(e)).toList();

    return listSessionType;
  }

  Future<String> addSession(int typeId, Session sesison, int cvId) async {
    String token = await storage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.post("/cvs/$cvId/sections",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: jsonEncode({
          "title": sesison.sessionTitle,
          "sectionTypeId": typeId,
          "cvId": cvId,
          "text": sesison.sessionText,
        }));
    if (201 != response.statusCode) {
      throw Exception("Failed to adding!");
    } else {
      result = "success";
    }
    return result;
  }

  Future<String> updateCV(CVDetail cvDetail) async {
    String token = await storage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.put(
      "/cvs/${cvDetail.cvId}",
      headers: {
        "Authorization": "bearer $token",
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "cvId": cvDetail.cvId,
        "title": cvDetail.title,
        "majorId": cvDetail.major.majorId,
      }),
    );
    if (response.statusCode == 204) {
      result = "Update cv title successful";
    } else {
      throw Exception("Failed to update!");
    }
    return result;
  }
}
