/*
 * File: post_section_detail.dart
 * Project: CVideo
 * File Created: Saturday, 20th June 2020 12:22:26 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 20th June 2020 12:22:29 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';

class PostDectionDetail extends StatelessWidget {
  final String sectionTitle;
  final String sectionDetail;
  const PostDectionDetail(
      {Key key, @required this.sectionTitle, @required this.sectionDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            sectionTitle,
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            width: size.width,
            child: Text(
              sectionDetail,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
