/*
 * File: scr011_card_event.dart
 * Project: CVideo
 * File Created: Wednesday, 1st July 2020 4:46:35 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 1st July 2020 4:48:44 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:equatable/equatable.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class CardPressed extends CardEvent {
  final int cvId;
  CardPressed({this.cvId});

  List<Object> get props => [];
}
