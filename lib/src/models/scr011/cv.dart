/*
 * File: cv.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 8:38:02 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 24th June 2020 8:38:34 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
class CV {
  int cvId;
  String cvTitle;
  String created;
  bool isSelected;

  CV({this.cvId,this.created, this.cvTitle, this.isSelected = false});

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
        cvId: json['cvId'] as int,
        cvTitle: json['title'] as String ?? "",
        created: json['created'] as String ?? "",
        isSelected: false);
  }
}
