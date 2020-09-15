import 'package:cvideo_mobile/src/models/models.dart';

import '../repositories.dart';

class DetailCVRepository {
  final String resumeId;
  DetailCVProvider _detailCVProvider = DetailCVProvider();

  DetailCVRepository(this.resumeId);
  Future<CVDetail> fetchCVDetail(String lang) =>
      _detailCVProvider.fetchCVDetail(resumeId, lang);
  Future<String> deleteSession(int sessionId, int cvId) =>
      _detailCVProvider.deleteSession(sessionId, cvId);
  Future<String> deleteField(int sessionId, int cvId, int fieldId) =>
      _detailCVProvider.deleteField(sessionId, cvId, fieldId);
  Future<String> deleteVideo(int sessionId, int cvId, int videoId) =>
      _detailCVProvider.deleteVideo(sessionId, cvId, videoId);
  Future<String> updateSession(Session session, int cvId) =>
      _detailCVProvider.updateSession(session, cvId);
  Future<String> updateField(int sessionId, int cvId, Field field) =>
      _detailCVProvider.updateField(sessionId, field, cvId);
  Future<String> updateCV(CVDetail cvDetail) =>
      _detailCVProvider.updateCV(cvDetail);
  Future<String> addField(int sessionId, int cvId, Field field) =>
      _detailCVProvider.createField(field, cvId, sessionId);
  Future<List<SessionType>> fetchSessionType(String lang) =>
      _detailCVProvider.fetchAllSessionType(lang);
  Future<String> addSession(int typeId, Session session, int cvId) =>
      _detailCVProvider.addSession(typeId, session, cvId);
}
