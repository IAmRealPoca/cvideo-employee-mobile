/*
 * File: scr008_dropdown_state.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 1:53 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:08 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DropdownState extends Equatable {
  const DropdownState();

  @override
  List<Object> get props => [];
}

class DropdownChanged extends DropdownState {
  final int valueChanged;

  const DropdownChanged({@required this.valueChanged});

  @override
  List<Object> get props => [this.valueChanged];
}
