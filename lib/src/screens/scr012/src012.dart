/*
 * File: scr013.dart
 * Project: CVideo
 * File Created: Tuesday, 30th June 2020 5:20:11 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 30th June 2020 5:20:37 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'dart:async';

import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/screens/scr012/bottom_load.dart';
import 'package:cvideo_mobile/src/screens/scr012/list_recruitment_post_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'list_recruitment_post_card.dart';

// ignore: must_be_immutable
class SCR012 extends StatefulWidget {
  SCR012({
    Key key,
    this.title,
    this.url,
  }) : super(key: key);
  final String url;
  final String title;

  @override
  _SCR012State createState() => _SCR012State();
}

class _SCR012State extends State<SCR012> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  Completer<void> _refreshCompleter;
  RecruitmentListBloc _recruitmentListBloc;

  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _scrollController.addListener(_onScroll);
    _recruitmentListBloc = BlocProvider.of<RecruitmentListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<RecruitmentListBloc, RecruitmentListState>(
                builder: (context, state) {
                  if (state is RecruitmentListFetchInitial) {
                    return Expanded(
                      child: Container(
                        width: size.width,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              ListRecruitmentPostLoading(),
                              ListRecruitmentPostLoading(),
                              ListRecruitmentPostLoading(),
                              ListRecruitmentPostLoading(),
                              ListRecruitmentPostLoading(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is RecruitmentListFetchedSuccess) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                    if (state.recruitmentPostList.isNotEmpty) {
                      return Expanded(
                        child: RefreshIndicator(
                            child: Container(
                              color: Colors.grey[100],
                              height: double.infinity,
                              width: size.width,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return index >=
                                            state.recruitmentPostList.length
                                        ? BottomLoader()
                                        : ListRecruitmentPostCard(
                                            recruitmentPost: state
                                                .recruitmentPostList[index],
                                          );
                                  },
                                  itemCount: state.hasReachedMax
                                      ? state.recruitmentPostList.length
                                      : state.recruitmentPostList.length + 1,
                                  controller: _scrollController),
                            ),
                            onRefresh: () {
                              BlocProvider.of<RecruitmentListBloc>(context)
                                  .add(RecruitmentListFetched(widget.url));
                              return _refreshCompleter.future;
                            }),
                      );
                    } else {
                      return Expanded(
                        child: Container(
                          height: size.height,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  return Container(
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListRecruitmentPostLoading(),
                          ListRecruitmentPostLoading(),
                          ListRecruitmentPostLoading(),
                          ListRecruitmentPostLoading(),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _recruitmentListBloc.add(RecruitmentListFetched(widget.url));
    }
  }
}
