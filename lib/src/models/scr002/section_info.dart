/*
 * File: section_info.dart
 * Project: CVideo
 * File Created: Monday, 29th June 2020 2:05:30 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 29th June 2020 2:05:35 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
class SectionInfo {
  final int newsFeedSectionId;
  final String title;
  final String url;
  final int dispOrder;

  const SectionInfo(
      {this.newsFeedSectionId, this.title, this.url, this.dispOrder});

  factory SectionInfo.fromJson(Map<String, dynamic> json) {
    return SectionInfo(
        newsFeedSectionId: json['newsFeedSectionId'] as int,
        title: json['title'] as String,
        url: json['url'] as String ?? "",
        dispOrder: json['dispOrder'] as int);
  }
}
