/*
 * File: scr005_employee_info_bloc.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 9:28:15 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 11th July 2020 3:12:32 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
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

class UpdateEmployeeInfoBloc
    extends Bloc<UpdateEmployeeInfoEvent, UpdateEmployeeInfoState> {
  final EmployeeRepository employeeRepository;
  UpdateEmployeeInfoBloc({this.employeeRepository})
      : assert(employeeRepository != null);
  @override
  UpdateEmployeeInfoState get initialState => UpdateEmployeeInfoInitial();

  @override
  Stream<UpdateEmployeeInfoState> mapEventToState(
      UpdateEmployeeInfoEvent event) async* {
    try {
      yield UpdateEmployeeInfoProcessing();
      if (event is UpdateEmployeeInfoRequest) {
        final String message =
            await employeeRepository.updateEmployeeInfo(event.employeeProfile);
        if (message == "success") {
          yield UpdateEmployeeInfoSuccess(message: message);
        } else {
          yield UpdateEmployeeInfoFailure();
        }
      }
    } catch (_) {
      yield UpdateEmployeeInfoFailure();
    }
  }
}
