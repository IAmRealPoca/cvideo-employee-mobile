/*
 * File: scr005_employee_info_event.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 9:27:44 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 11th July 2020 3:08:40 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'package:cvideo_mobile/src/models/scr005/employee_profile.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateEmployeeInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateEmployeeInfoRequest extends UpdateEmployeeInfoEvent {
  final EmployeeProfile employeeProfile;
  UpdateEmployeeInfoRequest({this.employeeProfile});
}
