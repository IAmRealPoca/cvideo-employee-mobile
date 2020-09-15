/*
 * File: scr011_list_cv_card_bloc.dart
 * Project: CVideo
 * File Created: Wednesday, 1st July 2020 4:47:09 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 1st July 2020 4:58:23 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/blocs/scr011/listcv/scr011_list_cv_card_barrel.dart';

import 'package:cvideo_mobile/src/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  List<CV> cvList;
  @override
  void onTransition(Transition<CardEvent, CardState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  CardBloc({this.cvList});
  @override
  CardState get initialState => CardInactive();

  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    if (event is CardPressed) {
      cvList.forEach((element) {
        if (event.cvId == element.cvId) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      });
      yield CardActive(cvLists: cvList);
    }
  }
}
