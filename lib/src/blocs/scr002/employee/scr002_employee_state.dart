/*
 * File: scr002_employee_state.dart
 * Project: CVideo
 * File Created: Sunday, 14th June 2020 2:42:17 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 14th June 2020 2:46:16 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:flutter/cupertino.dart';

abstract class EmployeeState{}

class UninitialisedEmployeeState extends EmployeeState{}

class EmployeeInforFetching extends EmployeeState{}

class EmployeeInforFetchedSuccess extends EmployeeState{
  final Employee employee;
  EmployeeInforFetchedSuccess({@required this.employee});
}

class EmployeeInforFetched extends EmployeeState{}
class EmployeeInforFetchedFailure extends EmployeeState{}
