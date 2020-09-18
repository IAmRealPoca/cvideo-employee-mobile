class Field {
  final String fieldName;
  final String fieldText;
  final int fieldId;

  Field({this.fieldName, this.fieldText, this.fieldId});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      fieldName: json['name'] == null ? "" : json['name'].toString(),
      fieldText: json['text'] == null ? "" : json['text'].toString(),
      fieldId: json['fieldId'],
    );
  }
}
