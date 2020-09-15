/*
 * File: employee.dart
 * Project: CVideo
 * File Created: Sunday, 14th June 2020 1:26:02 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 14th June 2020 1:26:05 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
class Employee {
  int id;
  String fullName;
  String email;
  String gender;
  String phone;
  String address;
  String avatar;
  DateTime dateOfBirth;
  int numOfCVs;
  int numOfVideos;

  Employee(
      {this.id,
      this.fullName,
      this.email,
      this.gender,
      this.phone,
      this.address,
      this.avatar,
      this.dateOfBirth,
      this.numOfCVs,
      this.numOfVideos});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['accountId'] as int,
      fullName: json['fullName'] as String ?? "",
      email: json['email'] as String ?? "",
      gender: json['gender'] as String ?? "",
      phone: json['phone'] as String ?? "",
      address: json['address'] as String ?? "",
      avatar: json['avatar'] as String ?? "",
      dateOfBirth: DateTime.parse(json['dateOfBirth'].toString()),
      numOfCVs: json['numOfCVs'] as int,
      numOfVideos: json['numOfVideos'] as int,
    );
  }
}
