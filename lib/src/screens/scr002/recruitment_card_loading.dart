/*
 * File: recruitment_card_loading.dart
 * Project: CVideo
 * File Created: Monday, 20th July 2020 8:25:44 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 20th July 2020 8:25:48 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecruitmentCardLoading extends StatelessWidget {
  const RecruitmentCardLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: size.width * 0.73,
      height: size.height * 0.20,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Shimmer.fromColors(
            baseColor: AppColors.baseColorLoading,
            highlightColor: AppColors.hightlightColorLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //show comany avatar, joc title, company name
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 19.0,
                          width: size.width * 0.4,
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
                    ))
                  ],
                ),

                /// Second row in the card: location
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    height: 18.0,
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),

                /// Thrid row in the card: salary
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    height: 18.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),

                /// Fourth row: due date
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: AppColors.secondaryTextColor,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    height: 18.0,
                  ),
                ),
              ],
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
