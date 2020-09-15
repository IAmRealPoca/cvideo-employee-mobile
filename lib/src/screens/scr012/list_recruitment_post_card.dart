/*
 * File: list_recruitment_post_card.dart
 * Project: CVideo
 * File Created: Tuesday, 30th June 2020 5:49:22 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 30th June 2020 5:49:26 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/screens/scr010/scr010.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ListRecruitmentPostCard extends StatelessWidget {
  static const double _companyImageSize = 55.0;
  static const double _companyImagePadding = 15.0;
  static const double _distanceBetweenRow = 5.0;
  static const double _paddingCardBottom = 4.0;
  static const double _paddingCardText = 7.0;

  const ListRecruitmentPostCard({
    Key key,
    this.recruitmentPost,
  }) : super(key: key);

  final RecruitmentPost recruitmentPost;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: _paddingCardBottom),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 151,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: _paddingCardText, bottom: _paddingCardText, right: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //show image company
                  Container(
                    height: _companyImageSize,
                    width: _companyImageSize,
                    margin: EdgeInsets.only(
                        top: _companyImagePadding,
                        right: _companyImagePadding,
                        bottom: _companyImagePadding,
                        left: _companyImagePadding),
                    child: recruitmentPost.company.img.isNotEmpty
                        ? Image.network(recruitmentPost.company.img)
                        : SvgPicture.asset(
                            "assets/screens/scr002/avatar_company.svg"),
                  ),
                  SizedBox(
                    width: _distanceBetweenRow,
                  ),

                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        //show recruitment post title
                        Container(
                          width: size.width,
                          child: Tooltip(
                            message: recruitmentPost.title,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              recruitmentPost.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: AppColors.primaryDarkColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _distanceBetweenRow,
                        ),

                        //show company name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              recruitmentPost.company.companyName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: AppColors.primaryDarkColor
                                      .withOpacity(0.6)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: _distanceBetweenRow,
                        ),

                        //show location recruitment post
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/screens/scr002/ic_location.svg",
                              width: 10,
                              color:
                                  AppColors.primaryDarkColor.withOpacity(0.6),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Tooltip(
                                message: recruitmentPost.location,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Text(
                                  AppLocalizations.of(context)
                                          .translate("scr002.location") +
                                      recruitmentPost.location,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _distanceBetweenRow,
                        ),

                        //show due date recruitment post
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/screens/scr002/ic_clock.svg",
                              width: 12,
                              color:
                                  AppColors.primaryDarkColor.withOpacity(0.6),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                      .translate("scr002.dueDate") +
                                  (DateFormat("yyyy-MM-dd").format(
                                      DateFormat("yyyy-MM-dd")
                                          .parse(recruitmentPost.duteDate))),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.primaryDarkColor
                                      .withOpacity(0.6)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _distanceBetweenRow,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/screens/scr002/ic_money.svg",
                              width: 12,
                              color:
                                  AppColors.primaryDarkColor.withOpacity(0.6),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
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
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.primaryDarkColor
                                      .withOpacity(0.6)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _distanceBetweenRow,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.SCR010_SCREEN,
            arguments: ScreenArguments(postId: recruitmentPost.postId));
      },
    );
  }
}
