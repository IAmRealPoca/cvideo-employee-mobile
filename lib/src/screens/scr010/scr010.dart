/*
 * File: scr010.dart
 * Project: CVideo
 * File Created: Thursday, 18th June 2020 9:08:16 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Thursday, 18th June 2020 9:08:22 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'dart:async';

import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr010/round_apply_button.dart';
import 'package:cvideo_mobile/src/screens/scr010/post_section_detail.dart';
import 'package:cvideo_mobile/src/screens/scr011/scr011.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SCR010 extends StatefulWidget {
  static const double _widthIcon = 15.0;
  static const double _sizeText = 15.0;

  const SCR010({
    Key key,
  }) : super(key: key);

  @override
  _SCR010State createState() => _SCR010State();
}

Completer<void> _refreshCompleter;

void initState() {
  _refreshCompleter = Completer<void>();
}

class _SCR010State extends State<SCR010> with WidgetsBindingObserver {
  bool check;
  bool isPopped;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    isPopped = false;
    check = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return RecruitmentDetailBloc(postRepository: PostRepository())
          ..add(RecruitmentDetailRequest(args.postId));
      },
      child: BlocBuilder<RecruitmentDetailBloc, RecruitmentDetailState>(
          builder: (context, state) {
        if (state is RecruitmentDetailFetchedFailure) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("scr011.applyCVFail"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: AppColors.primaryDarkColor),
                ),
              ),
            ),
          );
        }
        if (state is RecruitmentDetailFetchedSuccess) {
          check = isPopped ? check : state.recruitmentPost.isApplied;
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          return RefreshIndicator(
              child: Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    //show background inmage
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: size.height * 0.35,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/screens/scr002/background.png",
                                ),
                                fit: BoxFit.fill)),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: size.height * 0.9,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35.0),
                                      topRight: Radius.circular(35.0)),
                                  color: Colors.white,
                                ),
                                height: size.height * 0.82,
                                width: size.width,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 70.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Expanded(
                                            child: Tooltip(
                                              message:
                                                  state.recruitmentPost.title,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: Center(
                                                child: Text(
                                                  state.recruitmentPost.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .primaryDarkColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          state.recruitmentPost.company
                                              .companyName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.primaryDarkColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      color: AppColors.primaryColor,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 24, bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 14,
                                                ),
                                                SvgPicture.asset(
                                                    "assets/screens/scr002/ic_location.svg",
                                                    width: 12,
                                                    color: Colors.white),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                SvgPicture.asset(
                                                    "assets/screens/scr002/ic_money.svg",
                                                    width: SCR010._widthIcon,
                                                    color: Colors.white),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SvgPicture.asset(
                                                    "assets/screens/scr002/ic_clock.svg",
                                                    width: SCR010._widthIcon,
                                                    color: Colors.white),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Container(
                                                  width: size.width - 60,
                                                  child: Tooltip(
                                                    message: state
                                                        .recruitmentPost
                                                        .location,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  "scr002.location") +
                                                          state.recruitmentPost
                                                              .location,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize:
                                                              SCR010._sizeText,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                          .translate(
                                                              "scr002.salary") +
                                                      (((state.recruitmentPost
                                                                      .maxSalary ==
                                                                  0) &&
                                                              (state.recruitmentPost
                                                                      .maxSalary ==
                                                                  0))
                                                          ? AppLocalizations.of(context)
                                                              .translate(
                                                                  "scr002.negotiation")
                                                          : (state.recruitmentPost
                                                                      .minSalary
                                                                      .toString() +
                                                                  " - " +
                                                                  state
                                                                      .recruitmentPost
                                                                      .maxSalary
                                                                      .toString()) +
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate("scr002.concurrency")),
                                                  style: TextStyle(
                                                      fontSize:
                                                          SCR010._sizeText,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                          .translate(
                                                              "scr002.dueDate") +
                                                      (DateFormat("yyyy-MM-dd")
                                                          .format(DateFormat(
                                                                  "yyyy-MM-dd")
                                                              .parse(state
                                                                  .recruitmentPost
                                                                  .duteDate))),
                                                  style: TextStyle(
                                                      fontSize:
                                                          SCR010._sizeText,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    //show detail post
                                    Expanded(
                                      child: Container(
                                        width: size.width,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: <Widget>[
                                                PostDectionDetail(
                                                    sectionTitle:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr010.jobDes"),
                                                    sectionDetail: state
                                                        .recruitmentPost
                                                        .jobDescription),
                                                PostDectionDetail(
                                                    sectionTitle:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr010.jobReq"),
                                                    sectionDetail: state
                                                        .recruitmentPost
                                                        .jobRequirement),
                                                PostDectionDetail(
                                                    sectionTitle:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr010.jobBen"),
                                                    sectionDetail: state
                                                        .recruitmentPost
                                                        .jobBenefit),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 70,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: (size.width / 2) - 58,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: state.recruitmentPost.company.img
                                              .isNotEmpty
                                          ? NetworkImage(
                                              state.recruitmentPost.company.img)
                                          : AssetImage(
                                              "assets/screens/scr002/avatar_comany.png"),
                                      fit: BoxFit.cover),
                                ),
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: size.height * 0.92,
                      left: (size.width / 2) - 58,
                      child: Container(
                          child: check
                              ? RoundApplyButton(
                                  isApplied: true,
                                  onPressed: () {},
                                )
                              : RoundApplyButton(
                                  isApplied: false,
                                  onPressed: () {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) async {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.SCR011_SCREEN,
                                              arguments: ScreenArguments011(
                                                postId: args.postId,
                                                isApplied: state
                                                    .recruitmentPost.isApplied,
                                                majorId: state.recruitmentPost
                                                    .major.majorId,
                                              ))
                                          .then((value) {
                                        // BlocProvider.of<RecruitmentDetailBloc>(context)
                                        //   ..add(RecruitmentDetailRequest(value));
                                        var arguments = ModalRoute.of(context)
                                            .settings
                                            .arguments as ScreenArguments;
                                        setState(() {
                                          check = arguments.isPopped;
                                          isPopped = arguments.isPopped;
                                        });
                                      });
                                    });
                                  },
                                )),
                    )
                  ],
                ),
              ),
              onRefresh: () {
                BlocProvider.of<RecruitmentDetailBloc>(context)
                    .add(RecruitmentDetailRequest(args.postId));
                return _refreshCompleter.future;
              });
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.primaryDarkColor),
            ),
          ),
        );
      }),
    ));
  }
}

class ScreenArguments {
  int postId;
  bool isPopped;
  ScreenArguments({this.postId, this.isPopped = false});
}
