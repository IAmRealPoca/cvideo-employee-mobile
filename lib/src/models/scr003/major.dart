class MajorDetail {
  final int majorId;
  final String majorName;

  MajorDetail({this.majorId, this.majorName});

  factory MajorDetail.fromJson(Map<String, dynamic> json) {
    return MajorDetail(
      majorId: json['majorId'],
      majorName: json['majorName'] as String ?? "",
    );
  }
}
