/*
 * File: info_container_loading.dart
 * Project: CVideo
 * File Created: Monday, 20th July 2020 9:51:25 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 20th July 2020 9:52:08 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InforContainerLoading extends StatelessWidget {
  const InforContainerLoading({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: AppColors.primaryColor,
        height: 140,
        width: size.width,
        child: Shimmer.fromColors(
          baseColor: AppColors.baseColorLoading,
          highlightColor: AppColors.hightlightColorLoading,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 13.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: AppColors.secondaryTextColor,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      height: 20.0,
                      width: size.width * 0.3,
                    ),
                    Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 18.0,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 18.0,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
