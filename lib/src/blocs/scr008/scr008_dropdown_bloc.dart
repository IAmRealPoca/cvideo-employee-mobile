/*
 * File: scr008_dropdown_bloc.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 1:53 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:08 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/scr008/scr008_bloc_barrel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  final int selectedValueDefault;

  DropdownBloc({@required this.selectedValueDefault});
  @override
  DropdownState get initialState =>
      DropdownChanged(valueChanged: selectedValueDefault);

  @override
  Stream<DropdownState> mapEventToState(DropdownEvent event) async* {
    if (event is DropdownChange) {
      yield* _mapDropdownChangeToState(event.changedValue);
    }
  }

  Stream<DropdownState> _mapDropdownChangeToState(int changedValue) async* {
    yield DropdownChanged(valueChanged: changedValue);
  }
}
