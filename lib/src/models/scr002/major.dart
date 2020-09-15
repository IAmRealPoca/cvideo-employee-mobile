/*
 * File: major.dart
 * Project: CVideo
 * File Created: Monday, 29th June 2020 5:36:23 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 29th June 2020 5:36:26 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
class Major {
  final int majorId;
  final String majorName;

  const Major({this.majorId, this.majorName});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
        majorId: json['majorId'] as int,
        majorName: json['majorName'] as String ?? "");
  }
}
