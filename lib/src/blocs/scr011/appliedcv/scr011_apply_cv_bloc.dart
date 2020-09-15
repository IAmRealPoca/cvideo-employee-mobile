/*
 * File: scr011_apply_cv_bloc.dart
 * Project: CVideo
 * File Created: Thursday, 2nd July 2020 10:49:22 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 3rd July 2020 11:49:57 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyCVBloc extends Bloc<ApplyCVEvent, ApplyCVState> {
  final CVRepository cvRepository;
  ApplyCVBloc({this.cvRepository}) : assert(cvRepository != null);
  @override
  ApplyCVState get initialState => ApplyCVInitial();

  @override
  Stream<ApplyCVState> mapEventToState(ApplyCVEvent event) async* {
    try {
      yield ApplyCVProcessing();
      if (event is ApplyCVRequest) {
        final String message =
            await cvRepository.applyCv(event.postId, event.cvId);
        if (message == "success") {
          yield ApplyCVSuccess(message: message);
        } else {
          yield ApplyCVFailure();
        }
      }
    } catch (_) {
      yield ApplyCVFailure();
    }
  }
}
