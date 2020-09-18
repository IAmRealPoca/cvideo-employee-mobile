/*
 * File: scr002_employee_bloc.dart
 * Project: CVideo
 * File Created: Sunday, 14th June 2020 1:04:58 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 14th June 2020 2:54:50 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeBloc({this.employeeRepository}) : assert(employeeRepository != null);

  @override
  void onTransition(Transition<EmployeeEvent, EmployeeState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  EmployeeState get initialState => UninitialisedEmployeeState();
  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    yield EmployeeInforFetching();
    if (event is EmployeeFetched) {
      try {
        final Employee employee = await employeeRepository.fetchEmployeeInfo();
        yield EmployeeInforFetchedSuccess(employee: employee);
      } catch (_) {
        yield EmployeeInforFetchedFailure();
      }
    }
  }
}
