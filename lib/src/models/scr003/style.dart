import 'package:equatable/equatable.dart';

class Style extends Equatable {
  final int styleId;
  final String styleName;

  Style({this.styleId, this.styleName});

  factory Style.fromJson(Map<String, dynamic> json) {
    return Style(
      styleId: json['styleId'],
      styleName: json['styleName'],
    );
  }
  @override
  List<Object> get props => [];
}
