class Resume {
  int cvId;
  String title;
  String created;
  Resume({this.created, this.cvId, this.title});

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      cvId: json['cvId'] as int,
      title: json['title'] as String ?? "",
      created: json['created'] as String ?? "",
    );
  }
}
