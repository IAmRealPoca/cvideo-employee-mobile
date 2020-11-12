import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';

class ResumeRepository {
  ResumeProvider _resumeProvider = ResumeProvider();
  Future<List<Resume>> fetchResumeList() => _resumeProvider.fetchResumeList();
  Future<List<SkillsDetail>> fetchSkillsList(String lang) =>
      _resumeProvider.fetchSkillsList(lang);
  Future<String> deleteCV(String cvId) => _resumeProvider.deleteCv(cvId);
  Future<String> addNewCV(String cvTitle, int skillsId) =>
      _resumeProvider.addNewCV(cvTitle, skillsId);
}
