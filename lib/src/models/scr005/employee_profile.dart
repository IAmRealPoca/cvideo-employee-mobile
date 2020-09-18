/*
 * File: employee_profile.dart
 * Project: CVideo
 * File Created: Tuesday, 7th July 2020 8:38:45 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 7th July 2020 8:38:48 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
class EmployeeProfile {
  int accountId;
  String fullName;
  String gender;
  String phoneNumber;
  String address;
  DateTime dateOfBirth;
  String avatar;

  EmployeeProfile(
      {this.accountId,
      this.fullName,
      this.gender,
      this.phoneNumber,
      this.address,
      this.dateOfBirth,
      this.avatar});

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
      accountId: json['accountId'] as int,
      fullName: json['fullName'] as String ?? "",
      gender: json['gender'] as String ?? "",
      phoneNumber: json['phoneNumber'] as String ?? "",
      address: json['address'] as String ?? "",
      avatar: json['avatar'] as String ?? "",
      dateOfBirth: DateTime.parse(json['dateOfBirth'].toString()),
    );
  }
}
