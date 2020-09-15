import 'package:meta/meta.dart';

class Question {
  final int id;
  final String content;
  final int duration;

  Question({
    @required this.id,
    @required this.content,
    @required this.duration,
  });

  static Question fromJson(dynamic json) {
    return Question(
      id: json['questionId'] as int,
      content: json['questionContent'] as String,
      duration: json['questionTime'] as int,
    );
  }
}
