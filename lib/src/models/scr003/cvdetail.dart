import '../models.dart';
import 'session.dart';

class CVDetail {
  int cvId;
  String title;
  Employee employee;
  List<Session> sessions;
  String created;
  Major major;

  CVDetail(
      {this.cvId,
      this.title,
      this.employee,
      this.sessions,
      this.created,
      this.major});

  factory CVDetail.fromJson(Map<String, dynamic> json) {
    // Iterable listSession = json['sections'] == null ? [] : json['sections'];
    List<Session> sections = [];
    var list = json['sections'] as List;
    if (sections != null) {
      sections = list.map((i) => Session.fromJson(i)).toList();
    }

    return CVDetail(
        cvId: json['cvId'],
        title: json['title'],
        employee: Employee.fromJson(json['employee']),
        created: json["created"],
        sessions: sections,
        major: Major.fromJson(json['major']));
  }
}
