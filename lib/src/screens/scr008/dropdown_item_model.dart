/*
 * File: dropdown_item_model.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 1:53 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:07 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DropdownItemModel extends Equatable {
  final String id;
  final String name;

  DropdownItemModel({@required this.id, @required this.name});

  @override
  List<Object> get props => [
        this.id,
        this.name,
      ];

  static DropdownItemModel fromJson(dynamic json) {
    return DropdownItemModel(
      id: json['id'] as String,
      name: json['title'] as String,
    );
  }
}
