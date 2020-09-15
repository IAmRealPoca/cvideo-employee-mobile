/*
 * File: recruitmentList.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 2:52:45 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 12th June 2020 2:52:55 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'recruitmentPost.dart';

class RecruitmentSection {
  String title;
  List<RecruitmentPost> recruitmentPosts;

  RecruitmentSection({this.title, this.recruitmentPosts});

  factory RecruitmentSection.fromJson(Map<String, dynamic> json) {
    List<RecruitmentPost> listRecruiment;
    List<dynamic> list = json['recruitmentPosts'];
    print(list);
    if (list.isNotEmpty) {
      listRecruiment =
          list.map((dynamic e) => RecruitmentPost.fromJson(e)).toList();
    }
    return RecruitmentSection(
        title: json['title'] as String, recruitmentPosts: listRecruiment);
  }
}
