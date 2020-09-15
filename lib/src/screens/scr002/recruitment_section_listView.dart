/*
 * File: recruitment_section_listView.dart
 * Project: CVideo
 * File Created: Saturday, 20th June 2020 12:52:57 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 22nd June 2020 4:21:39 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'dart:async';

import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/post_repository/post_repository.dart';
import 'package:cvideo_mobile/src/screens/scr002/recruitment_card_loading.dart';
import 'package:cvideo_mobile/src/screens/scr012/scr012_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'recruitment_post_card.dart';

// ignore: must_be_immutable
class RecruitmentSectionListView extends StatelessWidget {
  RecruitmentSectionListView({
    Key key,
    this.title,
    this.url,
  }) : super(key: key);

  final String title;
  final String url;
  Completer<void> _refreshCompleter;

  void initState() {
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    String _url;
    if (url.contains("?")) {
      _url = url + "&limit=5";
    } else {
      _url = url + "?limit=5";
    }
    Size size = MediaQuery.of(context).size;
    return BlocProvider<RecruitmentPostBloc>(
      create: (context) {
        return RecruitmentPostBloc(postRepository: PostRepository())
          ..add(RecruitmentPostFetched(_url));
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 26.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),

              //list section infor and url
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: AppColors.primaryDarkColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("scr002.seeAll"),
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.primaryDarkColor),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SCR012Main(
                                url: url,
                                title: title,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            BlocBuilder<RecruitmentPostBloc, RecruitmentPostState>(
              builder: (context, state) {
                if (state is RecruitmentPostFetching) {
                  return Container(
                    width: double.infinity,
                    height: size.height * 0.20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>  RecruitmentCardLoading(),
                      itemCount: 5,
                    ),
                  );
                }
                if (state is RecruitmentPostFetchedSuccess) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();

                  if (state.recruitmentPostList.isEmpty) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                                      allowDrawingOutsideViewBox: true),
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("scr002.noJobSeeking"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: AppColors.primaryDarkColor),
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
                  return RefreshIndicator(
                      child: Container(
                        width: double.infinity,
                        height: 170,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: RecruitmentPostCard(
                                      recruitmentPost:
                                          state.recruitmentPostList[index]));
                            }
                            return RecruitmentPostCard(
                                recruitmentPost:
                                    state.recruitmentPostList[index]);
                          },
                          itemCount: state.recruitmentPostList.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      onRefresh: () {
                        BlocProvider.of<RecruitmentPostBloc>(context)
                            .add(RecruitmentPostFetched(_url));
                        return _refreshCompleter.future;
                      });
                }
                return Container(
                  height: size.height * 0.20,
                  child: Center(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                      ),
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
