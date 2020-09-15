/*
 * File: scr011.dart
 * Project: CVideo
 * File Created: Tuesday, 23rd June 2020 8:39:55 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 23rd June 2020 8:40:19 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'dart:async';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr001/scr001.dart';
import 'package:cvideo_mobile/src/screens/scr010/scr010.dart';
import 'package:cvideo_mobile/src/screens/scr011/round_add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'apply_button.dart';
import 'list_cv_card.dart';

class SCR011 extends StatefulWidget {
  const SCR011({
    Key key,
  }) : super(key: key);

  @override
  _SCR011State createState() => _SCR011State();
}

Completer<void> _refreshCompleter;

void initState() {
  _refreshCompleter = Completer<void>();
}

class _SCR011State extends State<SCR011> {
  List<CV> cvLists;
  int _idCV = -1;
  @override
  Widget build(BuildContext context) {
    final ScreenArguments011 args = ModalRoute.of(context).settings.arguments;

    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return BlocProvider<CVListBloc>(
      create: (context) {
        return CVListBloc(cvRepository: CVRepository())
          ..add(CVListFetched(majorId: args.majorId));
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (authenContext, authenState) {
        if (authenState is AuthenticationFailure) {
          return SCR001();
        }
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: AppColors.primaryDarkColor,
                      size: 30,
                    ),
                    onPressed: () {
                      SchedulerBinding.instance.addPostFrameCallback((_) async {
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)
                        .translate("scr011.chooseCVMsg"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDarkColor,
                        fontSize: 15),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
              body: Container(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BlocBuilder<CVListBloc, CVListState>(
                          builder: (context, cvListstateFetch) {
                        if (cvListstateFetch is CVListFetchedSucess) {
                          _refreshCompleter?.complete();
                          _refreshCompleter = Completer();

                          if (cvListstateFetch.cvlists.isNotEmpty) {
                            //show list employee cv according to major of recruitment post
                            return Expanded(
                              child: RefreshIndicator(
                                  child: Container(
                                    child: BlocProvider<CardBloc>(
                                        create: (context) {
                                      return CardBloc(
                                          cvList: cvListstateFetch.cvlists);
                                    }, child: BlocBuilder<CardBloc, CardState>(
                                      builder: (context, cardState) {
                                        if (cardState is CardActive) {
                                          return Container(
                                            color: Colors.grey[100],
                                            height: double.infinity,
                                            width: size.width,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                //show list cv card
                                                children: _getCVCard(
                                                    cardState.cvLists, context),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            color: Colors.grey[100],
                                            height: double.infinity,
                                            width: size.width,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: _getCVCard(
                                                    cvListstateFetch.cvlists,
                                                    context),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )),
                                  ),
                                  onRefresh: () {
                                    BlocProvider.of<CVListBloc>(context).add(
                                        CVListFetched(majorId: args.majorId));
                                    return _refreshCompleter.future;
                                  }),
                            );
                          }
                          //show button add cv if there is no cv in major
                          return Expanded(
                            child: Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              .translate("scr011.noCVMsg"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color:
                                                  AppColors.primaryDarkColor),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RoundAddButton(onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.SCR003_SCREEN);
                                  }),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: Container(
                            child: Center(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      AppColors.primaryDarkColor),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BlocProvider<ApplyCVBloc>(create: (context) {
                return ApplyCVBloc(cvRepository: CVRepository());
              }, child: BlocBuilder<ApplyCVBloc, ApplyCVState>(
                  builder: (context, state) {
                if (state is ApplyCVInitial) {
                  return ApplyButton(
                    onPressed: () {
                      if (_idCV == -1) {
                        showAlertNotChooseDialog(context);
                      } else {
                        showAlertDialog(context, _idCV, args.postId);
                      }
                    },
                  );
                }
                if (state is ApplyCVProcessing) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.primaryDarkColor),
                      ),
                    ),
                  );
                }
                if (state is ApplyCVSuccess) {
                  SchedulerBinding.instance.addPostFrameCallback((_) async {
                    Navigator.of(context).popUntil((route) {
                      if (route.settings.name == AppRoutes.SCR010_SCREEN) {
                        (route.settings.arguments as ScreenArguments).isPopped =
                            true;
                        return true;
                      } else {
                        return false;
                      }
                    });
                  });
                }
                if (state is ApplyCVFailure) {
                  return Padding(
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
              }))),
        );
      }),
    );
  }

  //create list cv card
  List<Widget> _getCVCard(List<CV> cvLists, BuildContext context) {
    return cvLists
        .asMap()
        .map(
          (index, value) => MapEntry(
            index,
            ListCVsCard(
              cvTitle: value.cvTitle,
              cvCreatedDate: value.created,
              isActive: value.isSelected,
              onTap: () {
                setState(() {
                  _idCV = value.cvId;
                });
                BlocProvider.of<CardBloc>(context)
                    .add(CardPressed(cvId: value.cvId));
              },
            ),
          ),
        )
        .values
        .toList();
  }

  //show dialog confirm to applied cv
  showAlertDialog(BuildContext context, int cvId, int postId) {
    // Create button
    Widget yesButton = FlatButton(
      child: Text(
        AppLocalizations.of(context).translate("scr005.yes"),
        style: TextStyle(color: AppColors.primaryDarkColor, fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
        BlocProvider.of<ApplyCVBloc>(context)
          ..add(ApplyCVRequest(cvId: cvId, postId: postId));
      },
    );

    Widget noButton = FlatButton(
      child: Text(
        AppLocalizations.of(context).translate("scr005.no"),
        style: TextStyle(color: AppColors.primaryDarkColor, fontSize: 20),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // CHANGE BORDER RADIUS HERE
        side: BorderSide(width: 1),
      ),
      title: Text(AppLocalizations.of(context).translate("scr005.confirm")),
      content: Text(
        AppLocalizations.of(context).translate("scr011.applyCVMsg"),
      ),
      actions: [noButton, yesButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //show dialog if employee do not choose cv but press button apply
  showAlertNotChooseDialog(BuildContext context) {
    // Create button

    Widget noButton = FlatButton(
      child: Text(
        AppLocalizations.of(context).translate("scr005.return"),
        style: TextStyle(color: AppColors.primaryDarkColor, fontSize: 20),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // CHANGE BORDER RADIUS HERE
        side: BorderSide(width: 1),
      ),
      title: Text(AppLocalizations.of(context).translate("scr005.attention")),
      content: Text(
        AppLocalizations.of(context).translate("scr011.applyNoCVMsg"),
      ),
      actions: [noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _onWillPop() async {
    return true;
  }
}

class ScreenArguments011 {
  final int postId;
  final int majorId;
  final bool isApplied;
  ScreenArguments011({this.postId, this.isApplied, this.majorId});
}
