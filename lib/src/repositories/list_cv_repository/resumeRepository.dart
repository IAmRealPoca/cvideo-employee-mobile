import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';

class ResumeRepository {
  ResumeProvider _resumeProvider = ResumeProvider();
  Future<List<Resume>> fetchResumeList() => _resumeProvider.fetchResumeList();
  Future<List<MajorDetail>> fetchMajorList(String lang) =>
      _resumeProvider.fetchMajorList(lang);
  Future<String> deleteCV(String cvId) => _resumeProvider.deleteCv(cvId);
  Future<String> addNewCV(String cvTitle, int majorId) =>
      _resumeProvider.addNewCV(cvTitle, majorId);
}
