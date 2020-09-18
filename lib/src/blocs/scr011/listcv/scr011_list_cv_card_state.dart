/*
 * File: scr011_card_state.dart
 * Project: CVideo
 * File Created: Wednesday, 1st July 2020 4:46:50 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 1st July 2020 4:47:47 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:equatable/equatable.dart';

class CardState extends Equatable {
  const CardState();
  @override
  List<Object> get props => [];
}

class CardInactive extends CardState {
}

class CardActive extends CardState {
  final List<CV> cvLists;
  CardActive({this.cvLists});
}
