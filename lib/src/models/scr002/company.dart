/*
 * File: company.dart
 * Project: CVideo
 * File Created: Saturday, 6th June 2020 9:50:50 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 6th June 2020 9:50:57 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:flutter/material.dart';

class Company {
  final int id;
  final String companyName;
  final String address;
  final String email;
  final String phoneNum;
  final String img;

  Company({
    @required this.id,
    @required this.companyName,
    @required this.address,
    @required this.email,
    @required this.img,
    @required this.phoneNum,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        id: json['id'] as int,
        companyName: json['name'] as String ?? "",
        phoneNum: json['phone'] as String ?? "",
        email: json['email'] as String ?? "",
        address: json['address'] as String ?? "",
        img: json['avatar'] as String ?? "");
  }
}
