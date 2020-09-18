import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SCR009LangDropdownState extends Equatable {
  final String lang;

  SCR009LangDropdownState({@required this.lang});

  @override
  List<Object> get props => [this.lang];
}

