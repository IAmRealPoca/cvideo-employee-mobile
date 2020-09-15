/*
 * File: cv_repository.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 8:53:38 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 24th June 2020 9:00:13 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';

class CVRepository {
  CVProvider _cvProvider = CVProvider();
  Future<List<CV>> fetchListCVs(int majorId) =>
      _cvProvider.fetchListCVs(majorId);

  Future<String> applyCv(int postId, int cvId) =>
      _cvProvider.applyCv(postId, cvId);
}
