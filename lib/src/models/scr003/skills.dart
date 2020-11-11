class SkillsDetail {
  final int skillsId;
  final String skillsName;

  const SkillsDetail({this.skillsId, this.skillsName});

  factory SkillsDetail.fromJson(Map<String, dynamic> json) {
    return SkillsDetail(
        skillsId: json['skillsId'] as int,
        skillsName: json['skillsName'] as String ?? "");
  }
}
