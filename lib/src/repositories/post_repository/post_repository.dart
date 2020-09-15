/*
 * File: home_repository.dart
 * Project: CVideo
 * File Created: Friday, 12th June 2020 8:08:14 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 12th June 2020 9:14:41 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'package:cvideo_mobile/src/models/scr002/scr002_models.dart';
import 'post_provider.dart';

class PostRepository {
  PostProvider _postProvider = PostProvider();

  Future<List<SectionInfo>> fetchSectionInfo(String lang) =>
      _postProvider.fetchSectionInfo(lang);

  Future<List<RecruitmentPost>> fetchRecruitmentPostList(String url) =>
      _postProvider.fetchRecruitmentPostList(url);

  Future<RecruitmentPost> fetchRecruitmentPostDetail(int postId) =>
      _postProvider.fetchRecruitmentPostDetail(postId);
}
