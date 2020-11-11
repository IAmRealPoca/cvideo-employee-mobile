/*
 * File: home.dart
 * Project: CVideo
 * File Created: Friday, 5th June 2020 3:56:44 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 5th June 2020 3:56:48 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'dart:async';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/screens/scr002/info_container_loading.dart';
import 'package:cvideo_mobile/src/screens/scr002/recruitment_card_loading.dart';
import 'package:cvideo_mobile/src/screens/scr002/title_post_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'recruitment_section_listView.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final double _iconNumsCVSize = 11.0;
  final double _iconNumsVideosSize = 13.0;
  Home({Key key, this.tokenAuthen}) : super(key: key);

  final String tokenAuthen;
  Completer<void> _refreshCompleter;

  void initState() {
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    String lang = AppLocalizations.of(context).locale.languageCode;

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: <Widget>[
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return Container(
                    child: InforContainerLoading(),
                  );
                }
                if (state is AuthenticationSuccess) {
                  return BlocBuilder<EmployeeBloc, EmployeeState>(
                    builder: (context, state) {
                      if (state is EmployeeInforFetching) {
                        return Container(
                          child: InforContainerLoading(),
                        );
                      }
                      if (state is EmployeeInforFetchedSuccess) {
                        //show employee infor
                        return Container(
                          child: Container(
                            color: AppColors.primaryColor,
                            height: 140,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 13.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  //show employee name, avatar, number of videos and cvs
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      //employee name
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            state.employee.fullName
                                                .split(" ")
                                                .first,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      //employee avatar
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Container(
                                            height: 92,
                                            width: 92,
                                            child: CircleAvatar(
                                              backgroundImage: state.employee
                                                      .avatar.isNotEmpty
                                                  ? NetworkImage(
                                                      state.employee.avatar)
                                                  : AssetImage(
                                                      "assets/screens/scr002/user.png",
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //number of cvs and videos
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                      "assets/screens/scr002/ic_num_videos.svg",
                                                      width:
                                                          _iconNumsVideosSize,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      state.employee.numOfVideos
                                                              .toString() +
                                                          " Videos",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                      "assets/screens/scr002/ic_num_cvs.svg",
                                                      width: _iconNumsCVSize,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      state.employee.numOfCVs
                                                              .toString() +
                                                          " CVs",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return Container(
                        height: 140,
                        width: size.width,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryDarkColor),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is AuthenticationInitial) {
                  return Container(
                    height: 140,
                    width: size.width,
                    child: Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              AppColors.primaryDarkColor),
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  child: Container(
                    color: AppColors.primaryColor,
                    height: 140,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 13.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate("scr002.guest"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Colors.white),
                              ),
                              Container(
                                height: 90,
                                width: 90,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white54,
                                  backgroundImage: AssetImage(
                                      "assets/screens/scr002/user.png"),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                            "assets/screens/scr002/ic_num_videos.svg",
                                            width: _iconNumsVideosSize),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "0 Videos",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          "assets/screens/scr002/ic_num_cvs.svg",
                                          width: _iconNumsCVSize,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "0 CVs",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 5,
            ),

            //get list recruitment post
            BlocBuilder<RecruitmentBloc, RecruitmentState>(
              builder: (context, state) {
                if (state is RecruitmentFetching) {
                  return Expanded(
                      child: Container(
                    width: double.infinity,
                    height: size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TitlePostLoading(),
                            Container(
                              height: size.height * 0.20,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    RecruitmentCardLoading(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TitlePostLoading(),
                            Container(
                              height: size.height * 0.20,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    RecruitmentCardLoading(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TitlePostLoading(),
                            Container(
                              height: size.height * 0.20,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                    RecruitmentCardLoading(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
                }

                if (state is RecruitmentFetchSuccess) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();

                  return Expanded(
                    child: RefreshIndicator(
                        child: Container(
                          height: size.height,
                          width: double.infinity,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (state.sectionInfoList[index].url.isEmpty) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        state.sectionInfoList[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                            color: AppColors.primaryDarkColor),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: SvgPicture.asset(
                                                  "assets/screens/scr002/job_seeker.svg",
                                                  width: 30,
                                                  height: 30,
                                                  allowDrawingOutsideViewBox:
                                                      true),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      "scr002.noJobSeeking"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: AppColors
                                                      .primaryDarkColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return RecruitmentSectionListView(
                                title: state.sectionInfoList[index].title,
                                url: state.sectionInfoList[index].url,
                              );
                            },
                            itemCount: state.sectionInfoList.length,
                          ),
                        ),
                        onRefresh: () {
                          BlocProvider.of<RecruitmentBloc>(context)
                              .add(RecruitmentFetched(lang: lang));
                          return _refreshCompleter.future;
                        }),
                  );
                }
                if (state is RecruitmentFetchFailure) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                  return Expanded(
                    child: RefreshIndicator(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("scr011.applyCVFail"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: AppColors.primaryDarkColor),
                              ),
                            ),
                          ),
                        ),
                        onRefresh: () {
                          BlocProvider.of<RecruitmentBloc>(context)
                              .add(RecruitmentFetched(lang: lang));
                          return _refreshCompleter.future;
                        }),
                  );
                }
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
