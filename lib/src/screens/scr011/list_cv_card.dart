/*
 * File: list_cvs_apply.dart
 * Project: CVideo
 * File Created: Wednesday, 24th June 2020 1:50:08 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Wednesday, 24th June 2020 1:50:14 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ListCVsCard extends StatelessWidget {
  static const double _widthIcon = 13.0;
  static const double _companyImageSize = 55.0;
  static const double _companyImagePadding = 5.0;
  static const double _distanceBetweenRow = 5.0;
  static const double _paddingCardBottom = 0.0;
  static const double _paddingCardText = 7.0;
  ListCVsCard(
      {Key key,
      CV cv,
      Function onTap,
      @required bool isActive,
      @required String cvTitle,
      @required String cvCreatedDate})
      : this._isActive = isActive,
        this._onTap = onTap,
        this._cvTitle = cvTitle,
        this._cvCreatedDate = cvCreatedDate,
        super(key: key);

  final String _cvTitle;
  final String _cvCreatedDate;
  bool _isActive;
  Function _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: _paddingCardBottom),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: _isActive ? AppColors.primaryDarkColor : Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: _companyImageSize,
                  width: _companyImageSize,
                  margin: EdgeInsets.only(
                      top: _companyImagePadding,
                      right: _companyImagePadding,
                      bottom: _companyImagePadding,
                      left: _companyImagePadding),
                  //child: Image.network(recruitmentPost.company.img),
                  child:
                      SvgPicture.asset("assets/screens/scr011/cv_avatar.svg"),
                ),
                SizedBox(
                  width: _distanceBetweenRow,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _cvTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: AppColors.primaryDarkColor),
                          )
                        ],
                      ),
                      SizedBox(
                        width: _distanceBetweenRow,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/screens/scr002/ic_clock.svg",
                              width: 10,
                              color: AppColors.primaryDarkColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              (DateFormat("yyyy-MM-dd").format(
                                  DateFormat("yyyy-MM-dd")
                                      .parse(_cvCreatedDate))),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.primaryDarkColor),
                            ),
                          ]),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            "assets/screens/scr011/check.svg",
                            color: _isActive
                                ? AppColors.primaryDarkColor
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
