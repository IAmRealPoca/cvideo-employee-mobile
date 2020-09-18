/*
 * File: employee_provider.dart
 * Project: CVideo
 * File Created: Monday, 15th June 2020 12:28:45 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 16th June 2020 9:55:56 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'dart:async';
import 'dart:convert';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/models/scr005/employee_profile.dart';

class EmployeeProvider {
  final successCode = 200;
  Future<Employee> fetchCurrentEmployeeInfo() async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    final response = await AppHttpClient.get("/employees/current-employee/info",
        headers: {"Authorization": "bearer $token"});
    if (successCode != response.statusCode) {
      throw Exception("Failed to loading!");
    }

    final dataJson = jsonDecode(utf8.decode(response.bodyBytes));
    return Employee.fromJson(dataJson);
  }

  Future<String> updateEmployeeInfo(EmployeeProfile employeeProfile) async {
    AppStorage appStorage = AppStorage.instance;
    String token = await appStorage.readSecureApiToken();
    String result = "";
    final response = await AppHttpClient.put(
      "/employees/current-employee/info",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "bearer $token"
      },
      body: jsonEncode({
        'accountId': employeeProfile.accountId,
        'fullName': employeeProfile.fullName,
        'gender': employeeProfile.gender,
        'phone': employeeProfile.phoneNumber,
        'address': employeeProfile.address,
        'dateOfBirth': employeeProfile.dateOfBirth.toIso8601String(),
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 204) {
      return "success";
    } else {
      print("-----Status code: " + response.statusCode.toString());
    }
    return result;
  }
}
