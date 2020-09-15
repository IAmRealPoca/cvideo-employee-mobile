/*
 * File: list_recruitment_post_loading.dart
 * Project: CVideo
 * File Created: Monday, 20th July 2020 10:03:16 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 20th July 2020 10:03:21 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListRecruitmentPostLoading extends StatelessWidget {
  const ListRecruitmentPostLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 142,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Shimmer.fromColors(
            baseColor: AppColors.baseColorLoading,
            highlightColor: AppColors.hightlightColorLoading,
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 2),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //show image company
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            height: 19.0,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),

                        //show company name
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            height: 19.0,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),

                        //show location recruitment post
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            height: 19.0,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildCVQuantitySection({
    @required String title,
    @required int quantity,
    @required Color quantityColor,
  }) {
    const _TOTAL_CV_TITLE_FONT_SIZE = 18.0;
    const _TOTAL_CV_QUANTITY_FONT_SIZE = 17.0;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// CVs title
          Text(
            /// Set title
            title,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: _TOTAL_CV_TITLE_FONT_SIZE,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            /// Set CV quantity text
            "$quantity",
            style: TextStyle(
              /// Set quantity color text
              color: quantityColor,
              fontSize: _TOTAL_CV_QUANTITY_FONT_SIZE,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
