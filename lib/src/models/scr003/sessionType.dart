class SessionType {
  final int typeId;
  final String typeName;
  final int displayOrder;

  SessionType({this.typeId, this.typeName, this.displayOrder});

  factory SessionType.fromJson(Map<String, dynamic> json) {
    return SessionType(
      typeId: json['sectionTypeId'],
      typeName: json['sectionTypeName'] == null
          ? ""
          : json['sectionTypeName'].toString(),
      displayOrder: json['dispOrder'],
    );
  }
}
