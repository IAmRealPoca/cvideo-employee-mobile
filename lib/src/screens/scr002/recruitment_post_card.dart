/*
 * File: recruitment_post_card.dart
 * Project: CVideo
 * File Created: Saturday, 13th June 2020 6:10:57 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 6:11:49 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/screens/scr010/scr010.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class RecruitmentPostCard extends StatelessWidget {
  static const double _widthIcon = 13.0;
  static const double _companyImageSize = 55.0;
  static const double _companyImagePadding = 15.0;
  static const double _spaceBetweenRows = 6.0;
  static const double _spaceBetweenTextAndIcon = 8.0;

  const RecruitmentPostCard({
    Key key,
    this.recruitmentPost,
  }) : super(key: key);

  final RecruitmentPost recruitmentPost;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: size.width * 0.73,
      // post card
      child: GestureDetector(
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //show company avatar, post title, company's name
                Row(
                  children: <Widget>[
                    //show company avatar
                    Container(
                      height: _companyImageSize,
                      width: _companyImageSize,
                      margin: EdgeInsets.only(
                        top: _companyImagePadding,
                        right: _companyImagePadding,
                      ),
                      child: recruitmentPost.company.img.isNotEmpty
                          ? Image.network(recruitmentPost.company.img)
                          : SvgPicture.asset(
                              "assets/screens/scr002/avatar_company.svg"),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          //show post title,
                          Tooltip(
                            message: recruitmentPost.title,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              recruitmentPost.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.primaryDarkColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          //show company's name
                          Text(
                            recruitmentPost.company.companyName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppColors.primaryDarkColor
                                    .withOpacity(0.6)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: _spaceBetweenRows),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/screens/scr002/ic_location.svg",
                            width: 12,
                            color: AppColors.primaryTextColor.withOpacity(0.6),
                          ),
                          SizedBox(
                            width: _spaceBetweenTextAndIcon + 1,
                          ),
                          Expanded(
                            child: Tooltip(
                              message: recruitmentPost.location,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text(
                                AppLocalizations.of(context)
                                        .translate("scr002.location") +
                                    recruitmentPost.location,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: AppColors.primaryTextColor
                                        .withOpacity(0.6)),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: _spaceBetweenRows),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset("assets/screens/scr002/ic_money.svg",
                              width: _widthIcon,
                              color:
                                  AppColors.primaryTextColor.withOpacity(0.6)),
                          SizedBox(
                            width: _spaceBetweenTextAndIcon,
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                      .translate("scr002.salary") +
                                  (((recruitmentPost.maxSalary == 0) &&
                                          (recruitmentPost.maxSalary == 0))
                                      ? AppLocalizations.of(context)
                                          .translate("scr002.negotiation")
                                      : (recruitmentPost.minSalary.toString() +
                                              " - " +
                                              recruitmentPost.maxSalary
                                                  .toString()) +
                                          AppLocalizations.of(context)
                                              .translate("scr002.concurrency")),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.primaryTextColor
                                      .withOpacity(0.6)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: _spaceBetweenRows),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset("assets/screens/scr002/ic_clock.svg",
                              width: _widthIcon,
                              color:
                                  AppColors.primaryTextColor.withOpacity(0.6)),
                          SizedBox(
                            width: _spaceBetweenTextAndIcon,
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                      .translate("scr002.dueDate") +
                                  (DateFormat("yyyy-MM-dd").format(
                                      DateFormat("yyyy-MM-dd")
                                          .parse(recruitmentPost.duteDate))),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.primaryTextColor
                                      .withOpacity(0.6)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.SCR010_SCREEN,
              arguments: ScreenArguments(postId: recruitmentPost.postId));
        },
      ),
    );
  }
}
