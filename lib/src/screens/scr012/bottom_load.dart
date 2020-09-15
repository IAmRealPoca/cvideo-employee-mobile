/*
 * File: bottom_load.dart
 * Project: CVideo
 * File Created: Monday, 13th July 2020 2:34:27 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 2:34:38 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation(AppColors.primaryDarkColor),
          ),
        ),
      ),
    );
  }
}
