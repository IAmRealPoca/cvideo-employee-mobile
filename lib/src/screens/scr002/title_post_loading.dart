/*
 * File: title_post_loading.dart
 * Project: CVideo
 * File Created: Monday, 20th July 2020 8:57:21 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 20th July 2020 8:57:26 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TitlePostLoading extends StatelessWidget {
  const TitlePostLoading({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        margin: EdgeInsets.only(
          bottom: 10.0,
        ),
        child: Shimmer.fromColors(
          baseColor: AppColors.baseColorLoading,
          highlightColor: AppColors.hightlightColorLoading,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: AppColors.secondaryTextColor,
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            height: 30.0,
            width: size.width * 0.6,
          ),
        ));
  }
}
