/*
 * File: scr008.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 1:53 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:07 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */

import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'dropdown_section.dart';

/// [SCR008] is Recording Screen
class SCR008 extends StatelessWidget {
  static const _BACK_ICON_PATH = "assets/screens/common_icon/ic_back.svg";
  static const _RECORD_ICON_PATH = "assets/screens/common_icon/ic_recorder.svg";
  static const _BACK_ICON_WIDTH = 11.0;
  static const _SCREEN_PADDING_HORIZONTAL = 16.0;
  static const _RECORD_TITLE_FONT_SIZE = 16.0;
  static const _RECORD_TITLE_FONT_WEIGHT = FontWeight.w600;
  static const _RECORD_ICON_WIDTH = 75.0;

  final SCR008Repository scr008repository =
      SCR008Repository(scr008provider: SCR008Provider());

  @override
  Widget build(BuildContext context) {
    /// Get params from detail cv screen
    SCR008Arguments args = ModalRoute.of(context).settings.arguments;

    /// Set params for [VideoBloc]
    BlocProvider.of<VideoBloc>(context).setParams(args.cvId, args.sectionId);

    /// Create progress dialog for login loading
    final ProgressDialog progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: AppLocalizations.of(context)
          .translate("scr008.infoQuestionDownloading"),
      backgroundColor: Colors.white,
      borderRadius: 10.0,
      progressWidget: Container(
        padding: EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          backgroundColor: AppColors.primaryColor,
          valueColor: AlwaysStoppedAnimation(AppColors.primaryLightColor),
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
    );

    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        /// Bloc provider for question set and style
        BlocProvider<QuestionSetStyleBloc>(
          create: (context) =>
              QuestionSetStyleBloc(scr008repository: scr008repository)
                ..add(
                  QuestionSetStyleFetched(sectionId: args.sectionId),
                ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              /// Set back icon path
              _BACK_ICON_PATH,
              width: _BACK_ICON_WIDTH,
              color: AppColors.secondaryTextColor,
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          centerTitle: true,

          /// AppBar center title
          title: Text(
            AppLocalizations.of(context).translate("scr008.appBarTitle"),
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(currentIndex: 1),

        /// BlocBuilder for [VideoBloc]
        body: BlocListener<VideoBloc, VideoState>(
          listener: (context, videoBlocState) {
            if (videoBlocState is VideoStateRecorded) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<QuestionSetStyleBloc, QuestionSetStyleState>(
            builder: (context, questionSetStyleState) {
              /// Question and style is loading
              if (questionSetStyleState is QuestionSetStyleInitial) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                    valueColor:
                        AlwaysStoppedAnimation(AppColors.primaryLightColor),
                  ),
                );
              }

              /// Question and style load success
              if (questionSetStyleState is QuestionSetStyleSuccess) {
                /// Set default dropdown first question set is selected
                BlocProvider.of<VideoBloc>(context).add(
                    VideoEventQuestionSetChanged(
                        questionSetId:
                            questionSetStyleState.listQuestionSet[0].id));

                /// Set default dropdown first style is selected
                BlocProvider.of<VideoBloc>(context).add(VideoEventStyleChanged(
                    videoStyleId: questionSetStyleState.listStyle[0].id));

                return Container(
                  width: size.width,
                  height: size.height,

                  /// Set screen padding horizontal
                  padding: EdgeInsets.symmetric(
                      horizontal: _SCREEN_PADDING_HORIZONTAL),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),

                      /// Build dropdown for question set
                      BlocProvider<DropdownBloc>(
                        create: (dropdownQuestionContext) => DropdownBloc(
                            selectedValueDefault:
                                questionSetStyleState.listQuestionSet[0].id),

                        /// Build question set dropdown base on its state
                        child: BlocBuilder<DropdownBloc, DropdownState>(
                          builder: (context, dropdownState) {
                            if (dropdownState is DropdownChanged) {
                              return DropdownSection(
                                dropdownTitle: AppLocalizations.of(context)
                                    .translate("scr008.questionSetTitle"),
                                iconPath:
                                    "assets/screens/common_icon/ic_question_set.svg",
                                listChild:
                                    questionSetStyleState.listQuestionSet,
                                selectedValue: dropdownState.valueChanged,

                                /// Handle when dropdown question set change
                                press: (value) {
                                  /// change [questionSetId] in [VideoBloc]
                                  BlocProvider.of<VideoBloc>(context).add(
                                      VideoEventQuestionSetChanged(
                                          questionSetId: value));

                                  /// change [changedValue] in [DropdownBloc]
                                  BlocProvider.of<DropdownBloc>(context)
                                      .add(DropdownChange(changedValue: value));
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),

                      /// Build dropdown for video style
                      BlocProvider<DropdownBloc>(
                        create: (dropdownStyleContext) => DropdownBloc(
                            selectedValueDefault:
                                questionSetStyleState.listStyle[0].id),

                        /// Build video style dropdown base on its state
                        child: BlocBuilder<DropdownBloc, DropdownState>(
                          builder: (context, stylesDropdownState) {
                            if (stylesDropdownState is DropdownChanged) {
                              return DropdownSection(
                                dropdownTitle: AppLocalizations.of(context)
                                    .translate("scr008.questionStyleTitle"),
                                iconPath:
                                    "assets/screens/common_icon/ic_video_style.svg",
                                listChild: questionSetStyleState.listStyle,
                                selectedValue: stylesDropdownState.valueChanged,

                                /// Handle when video style dropdown change
                                press: (value) {
                                  /// Change [videoStyleId] in [VideoBloc]
                                  BlocProvider.of<VideoBloc>(context).add(
                                      VideoEventStyleChanged(
                                          videoStyleId: value));

                                  /// Change [changedValue] in [DropdownBloc]
                                  BlocProvider.of<DropdownBloc>(context)
                                      .add(DropdownChange(changedValue: value));
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        /// Build Record Icon section
                        child: BlocProvider<QuestionBloc>(
                          create: (context) =>
                              QuestionBloc(scr008repository: scr008repository),
                          child: BlocListener<QuestionBloc, QuestionState>(
                            listener: (context, questionState) {
                              // Questions are loaded successfully
                              if (questionState is QuestionSuccess) {
                                if (progressDialog.isShowing()) {
                                  progressDialog.hide();
                                }
                                BlocProvider.of<VideoBloc>(context).add(
                                  VideoEventRecorded(
                                    jsonQuestions: questionState.jsonQuestions,
                                  ),
                                );
                              }
                              // Question are loaded failed
                              if (questionState is QuestionFailure) {
                                if (progressDialog.isShowing()) {
                                  progressDialog.hide();
                                }
                                _showMaterialDialog(context);
                              }

                              if (questionState is QuestionLoading) {
                                progressDialog.show();
                              }
                            },
                            child: BlocBuilder<QuestionBloc, QuestionState>(
                              builder: (context, questionState) {
                                // Show the record button
                                return Center(
                                  child: GestureDetector(
                                    // When user press the record icon
                                    onTap: () {
                                      BlocProvider.of<QuestionBloc>(context)
                                          .add(QuestionFetched(
                                        setId:
                                            BlocProvider.of<VideoBloc>(context)
                                                .questionSetId,
                                      ));
                                    },
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            /// Set record icon path
                                            _RECORD_ICON_PATH,
                                            // Set width icon
                                            width: _RECORD_ICON_WIDTH,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "scr008.recordButtonTitle"),
                                            style: TextStyle(
                                              fontWeight:
                                                  _RECORD_TITLE_FONT_WEIGHT,
                                              fontSize: _RECORD_TITLE_FONT_SIZE,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// Question and style load failed
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate("scr008.errMsgCommon"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Show Dialog when question is loaded successful
  _showMaterialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(
          AppLocalizations.of(context).translate("scr008.errMsgCommon"),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Try it later'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

/// Class for [SCR008] arguments
class SCR008Arguments {
  final int cvId;
  final int sectionId;

  SCR008Arguments({@required this.cvId, @required this.sectionId});
}
