import 'package:equatable/equatable.dart';

abstract class SCR009LangDropdownEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SCR009LangDropdownEventStart extends SCR009LangDropdownEvent {}

class SCR009LangDropdownEventChange extends SCR009LangDropdownEvent {
  final String lang;

  SCR009LangDropdownEventChange({this.lang});

  @override
  List<Object> get props => [this.lang];
}