/*
 * File: employee_repository.dart
 * Project: CVideo
 * File Created: Sunday, 14th June 2020 2:29:01 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 14th June 2020 2:29:05 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/models/scr005/employee_profile.dart';
import 'employee_provider.dart';

class EmployeeRepository {
  EmployeeProvider _employeeProvider = EmployeeProvider();
  Future<Employee> fetchEmployeeInfo() =>
      _employeeProvider.fetchCurrentEmployeeInfo();

  Future<String> updateEmployeeInfo(EmployeeProfile employeeProfile) =>
      _employeeProvider.updateEmployeeInfo(employeeProfile);
}
