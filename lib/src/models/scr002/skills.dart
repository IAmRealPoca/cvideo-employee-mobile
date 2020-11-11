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
class Skills {
  final int skillsId;
  final String skillsName;

  const Skills({this.skillsId, this.skillsName});

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
        skillsId: json['skillsId'] as int,
        skillsName: json['skillsName'] as String ?? "");
  }
}
