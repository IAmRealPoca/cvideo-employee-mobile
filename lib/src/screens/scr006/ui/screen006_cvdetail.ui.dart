import 'dart:ui';
import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/models/scr008/scr008_models.dart';
import 'package:cvideo_mobile/src/screens/scr008/scr008.dart';
import 'package:cvideo_mobile/src/screens/scr014/scr014.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'sizes_helpers.dart';

Widget buildContent(
    BuildContext context,
    Employee user,
    List<Session> listSession,
    CVDetail cvDetail,
    List<Resume> listResume,
    BuildContext blocContext,
    String lang) {
  var list = listSession;
  if (listSession.isNotEmpty) {
    //sort list section
    Comparator<Session> displayComparator =
        (a, b) => a.displayOrder.compareTo(b.displayOrder);
    listSession.sort(displayComparator);

    return BlocListener<VideoBloc, VideoState>(
      listener: (context, state) {
        if (state is VideoStateSuccess) {
          BlocProvider.of<LoadCVDetailBloc>(context).add(FetchRefreshCVDtail(
              cvDetail: cvDetail,
              employee: cvDetail.employee,
              listSession: listSession,
              lang: lang));
          BlocProvider.of<VideoBloc>(context).add(VideoEventUploaded());
        }
      },
      child: Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildCVTitle(
                        context, cvDetail.title, listResume, cvDetail, lang),
                    buildUser(context, user),
                    if (listSession.isNotEmpty)
                      for (var session in list)
                        buildSession(context, session, cvDetail.cvId, lang),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<LoadCVDetailBloc>(blocContext)
                  .add(FetchSectionTypeEvent(lang: lang));
            },
            tooltip: AppLocalizations.of(context).translate("scr006.tooltip"),
            child: Icon(Icons.add),
            backgroundColor: AppColors.primaryDarkColor,
          )),
    );
  } else {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildCVTitle(
                      context, cvDetail.title, listResume, cvDetail, lang),
                  buildUser(context, user),
                  buildNoSession(context, lang)
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<LoadCVDetailBloc>(blocContext)
                .add(FetchSectionTypeEvent(lang: lang));
          },
          tooltip: AppLocalizations.of(context).translate("scr006.tooltip"),
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryDarkColor,
        ));
  }
}

Widget buildUser(BuildContext context, Employee user) {
  return Container(
      width: displayWidth(context),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    user.fullName,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 13),
                Text(
                  AppLocalizations.of(context).translate("scr006.DOB") +
                      DateFormat("dd-MM-yyyy").format(DateFormat("dd-MM-yyyy")
                          .parse(user.dateOfBirth.toString())),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).translate("scr006.gender") +
                      user.gender,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).translate("scr006.phone") +
                      user.phone,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).translate("scr006.email") +
                      user.email,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).translate("scr006.address") +
                      user.address,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.network(
                    user.avatar,
                    // width: displayWidth(context) * 0.,
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
}

Widget buildNoSession(BuildContext context, String lang) {
  return Container(
    // padding: EdgeInsets.fromLTRB(0, 130, 35, 0),
    margin: EdgeInsets.only(top: 130),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10),
            child: FlatButton(
              child: SvgPicture.asset(
                "assets/screens/scr003/add.svg",
                width: 50,
                color: AppColors.primaryLightColor,
              ),
              onPressed: () {
                BlocProvider.of<LoadCVDetailBloc>(context)
                    .add(FetchSectionTypeEvent(lang: lang));
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 0),
            child: Text(
                AppLocalizations.of(context).translate("scr006.btnAddSection"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.secondaryLightColor,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ),
  );
}

Widget buildSession(
    BuildContext context, Session session, int cvId, String lang) {
  return Container(
      width: displayWidth(context),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
      child: Column(
        children: <Widget>[
          buildSessionTitle(context, session, cvId, lang),
          if (session.sessionText.isNotEmpty)
            buildSessionText(context, session, cvId, lang),
          buildListField(context, session, cvId, lang),
          Container(
            child: buildListVideo(context, session, cvId, lang),
          ),
          buildAddText(context, session.sessionId, cvId, lang),
        ],
      ));
}

Widget buildListField(
    BuildContext context, Session session, int cvId, String lang) {
  var list = session.sessionField;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (var field in list)
        buildSessionField(context, field, session, cvId, lang),
    ],
  );
}

Widget buildListVideo(
    BuildContext context, Session session, int cvId, String lang) {
  var list = session.sessionVideo;
  //sort video by date
  Comparator<Video> displayComparator =
      (a, b) => b.videoId.compareTo(a.videoId);
  session.sessionVideo.sort(displayComparator);
  if (session.sessionVideo.length != 0) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoStateUploading) {
                  //video uploading => circle
                  if (session.sessionId == state.sectionId) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 4),
                        width: displayWidth(context) * 0.17,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryDarkColor),
                          ),
                        ),
                      ),
                    );
                  }
                }
                return Container();
              },
            ),
            for (var video in list)
              buildSessionVideo(context, video, cvId, session.sessionId, lang),
          ])),
    );
  } else {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              if (state is VideoStateUploading) {
                if (session.sessionId == state.sectionId) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 4),
                      width: displayWidth(context) * 0.17,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              AppColors.primaryDarkColor),
                        ),
                      ),
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

Widget buildSessionVideo(
    BuildContext context, Video video, int cvId, int sessionId, String lang) {
  return GestureDetector(
    onTap: () {
      //tap to view
      Navigator.of(context).pushNamed(AppRoutes.SCR014_SCREEN,
          arguments: SCR014Arguments(
              videoInfo: VideoInfo(
                  cvId: cvId,
                  sectionId: sessionId,
                  styleId: video.videoStyle.styleId,
                  videoUrl: video.videoUrl,
                  thumbUrl: video.thumbUrl,
                  coverUrl: video.coverUrl,
                  aspectRatio: video.aspectRatio)));
    },
    onLongPress: () {
      //long press to delete
      Flushbar(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 70),
        borderRadius: 8,
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.secondaryLightColor,
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        messageText: Text(
          AppLocalizations.of(context).translate("scr006.confirmDeleteVideo"),
          style: TextStyle(color: AppColors.primaryDarkColor),
        ),
        mainButton: FlatButton(
          child: Container(
            width: displayWidth(context) * 0.25,
            height: 20,
            child: Center(
              child: Icon(Icons.delete, color: AppColors.primaryDarkColor),
            ),
          ),
          onPressed: () {
            BlocProvider.of<LoadCVDetailBloc>(context)
              ..add(DeleteVideoEvent(
                  cvId: cvId,
                  sessionId: sessionId,
                  videoId: video.videoId,
                  lang: lang));
          },
        ),
      )..show(context);
    },
    //video cover
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
          width: displayWidth(context) * 0.18,
          height: 90,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(video.thumbUrl),
                  // image: CachedNetworkImageProvider(video.thumbUrl),
                  fit: BoxFit.fitHeight)),
          child: Center(
            child: SvgPicture.asset(
              "assets/screens/scr003/play.svg",
              width: 30,
              height: 30,
              color: AppColors.primaryDarkColor,
            ),
          )),
    ),
  );
}

Widget buildAddText(
    BuildContext context2, int sessionId, int cvId, String lang) {
  bool _validateTitle = true;
  bool _validateText = true;
  final _controllerFieldName = TextEditingController();
  final _controllerFieldText = TextEditingController();
  return BlocBuilder<VideoBloc, VideoState>(
    builder: (context, state) {
      if (!(state is VideoStateUploading)) {
        return Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //add field button
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context2,
                          builder: (BuildContext context1) {
                            return AlertDialog(
                              title: Text(
                                AppLocalizations.of(context1)
                                    .translate("scr006.addFieldTitle"),
                                style: TextStyle(
                                  color: AppColors.primaryDarkColor,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              actions: <Widget>[
                                //button of dialog
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: FlatButton(
                                      child: new Text(
                                        AppLocalizations.of(context1)
                                            .translate("scr006.btnCancel"),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context1).pop()),
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Container(
                                  // color: Colors.blue,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(3),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: AppColors.primaryDarkColor,
                                          )),
                                      child: new Text(
                                        AppLocalizations.of(context1)
                                            .translate("scr006.btnCreateCV"),
                                        style: TextStyle(
                                            color: AppColors.primaryDarkColor),
                                      ),
                                      onPressed: () => {
                                            if (_validateText == true ||
                                                _validateTitle == true)
                                              {
                                                //show error
                                                showDialog(
                                                    context: context1,
                                                    builder: (context) {
                                                      return new AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          title: Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    "scr006.errorEmpty"),
                                                          ),
                                                          actions: <Widget>[
                                                            new FlatButton(
                                                              child: new Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "scr006.btnUnderStood"),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        300]),
                                                              ),
                                                              onPressed: () => {
                                                                _controllerFieldText
                                                                        .text
                                                                        .isEmpty
                                                                    ? _validateText =
                                                                        true
                                                                    : _validateText =
                                                                        false,
                                                                _controllerFieldName
                                                                        .text
                                                                        .isEmpty
                                                                    ? _validateTitle =
                                                                        true
                                                                    : _validateTitle =
                                                                        false,
                                                                Navigator.of(
                                                                        context)
                                                                    .pop()
                                                              },
                                                            )
                                                          ]);
                                                    })
                                              }
                                            else
                                              {
                                                BlocProvider.of<
                                                            LoadCVDetailBloc>(
                                                        context2)
                                                    .add(AddFieldEvent(
                                                        Field(
                                                            fieldId: 0,
                                                            fieldName:
                                                                _controllerFieldName
                                                                    .text,
                                                            fieldText:
                                                                _controllerFieldText
                                                                    .text),
                                                        sessionId,
                                                        cvId,
                                                        lang)),
                                                Navigator.of(context1).pop()
                                              }
                                          }),
                                ),
                              ],
                              content: Builder(
                                builder: (context) {
                                  //place to input
                                  return Container(
                                    // color: Colors.amber,

                                    width: displayWidth(context),
                                    height: displayHeight(context) * 0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextField(
                                          controller: _controllerFieldName,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              labelText:
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "scr006.fieldName"),
                                              prefixIcon: Icon(
                                                Icons.title,
                                                color:
                                                    AppColors.primaryDarkColor,
                                              ),
                                              prefixText: ' ',
                                              suffixStyle: TextStyle(
                                                color:
                                                    AppColors.primaryDarkColor,
                                              )),
                                          //validation
                                          onChanged: (value) {
                                            value.isEmpty
                                                ? _validateTitle = true
                                                : _validateTitle = false;
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: _controllerFieldText,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              helperText: AppLocalizations.of(
                                                      context)
                                                  .translate("scr006.helpText"),
                                              hintText: AppLocalizations.of(
                                                      context)
                                                  .translate("scr006.hintText"),
                                              labelText:
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "scr006.fieldText"),
                                              prefixIcon: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: SvgPicture.asset(
                                                    "assets/screens/scr003/edit.svg",
                                                    width: 3,
                                                    height: 3,
                                                    color: AppColors
                                                        .primaryDarkColor,
                                                  ) // icon is 48px widget.
                                                  ),
                                              suffixStyle: TextStyle(
                                                color:
                                                    AppColors.primaryDarkColor,
                                              )),
                                          //validation
                                          onChanged: (value) {
                                            value.isEmpty
                                                ? _validateText = true
                                                : _validateText = false;
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: displayWidth(context2) * 0.42,
                      height: displayHeight(context2) * 0.05,
                      margin: EdgeInsets.fromLTRB(13, 7, 13, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.primaryDarkColor)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.add,
                                color: AppColors.primaryDarkColor,
                                size: 20,
                              ),
                            ),
                            Container(
                              child: Text(
                                AppLocalizations.of(context2)
                                    .translate("scr006.btnAddText"),
                                style: TextStyle(
                                    color: AppColors.primaryDarkColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //add video button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context2).pushNamed(AppRoutes.SCR008_SCREEN,
                          arguments: SCR008Arguments(
                              cvId: cvId, sectionId: sessionId));
                    },
                    child: Container(
                      width: displayWidth(context2) * 0.42,
                      height: displayHeight(context2) * 0.05,
                      margin: EdgeInsets.fromLTRB(3, 7, 13, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.primaryDarkColor)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.add,
                                color: AppColors.primaryDarkColor,
                                size: 20,
                              ),
                            ),
                            Container(
                              child: Text(
                                AppLocalizations.of(context2)
                                    .translate("scr006.btnCreateVideo"),
                                style: TextStyle(
                                    color: AppColors.primaryDarkColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]));
      }
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //add text
            Container(
              width: displayWidth(context2) * 0.42,
              height: displayHeight(context2) * 0.05,
              margin: EdgeInsets.fromLTRB(3, 7, 13, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.primaryTextColor.withOpacity(0.3))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.add,
                        color: AppColors.primaryTextColor.withOpacity(0.3),
                        size: 20,
                      ),
                    ),
                    Container(
                      child: Text(
                        AppLocalizations.of(context2)
                            .translate("scr006.btnAddText"),
                        style: TextStyle(
                            color: AppColors.primaryTextColor.withOpacity(0.3)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //add video
            Container(
              width: displayWidth(context2) * 0.42,
              height: displayHeight(context2) * 0.05,
              margin: EdgeInsets.fromLTRB(3, 7, 13, 0),
              // padding: EdgeInsets.only(left: 110),
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.primaryTextColor.withOpacity(0.3))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.add,
                        color: AppColors.primaryTextColor.withOpacity(0.3),
                        size: 20,
                      ),
                    ),
                    Container(
                      child: Text(
                        AppLocalizations.of(context2)
                            .translate("scr006.btnCreateVideo"),
                        style: TextStyle(
                            color: AppColors.primaryTextColor.withOpacity(0.3)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildSessionText(
    BuildContext context1, Session session, int cvId, String lang) {
  TextEditingController _controller = TextEditingController();
  bool _validate = false;
  _controller..text = session.sessionText;
  Session sessionUpdate;
  return Container(
      width: displayWidth(context1),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(13, 7, 13, 0),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Flushbar(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 70),
            borderRadius: 8,
            duration: Duration(seconds: 3),
            backgroundColor: AppColors.secondaryLightColor,
            boxShadows: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(3, 3),
                blurRadius: 3,
              ),
            ],
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
            messageText: Text(
              AppLocalizations.of(context1)
                  .translate("scr006.confirmDeleteSectionText"),
              style: TextStyle(color: AppColors.primaryDarkColor),
            ),
            mainButton: FlatButton(
              child: Container(
                width: displayWidth(context1) * 0.25,
                height: 20,
                child: Center(
                  child: Icon(Icons.delete, color: AppColors.primaryDarkColor),
                ),
              ),
              onPressed: () {
                updateSessionText(
                    context1,
                    Session(
                        icon: session.icon,
                        sessionField: session.sessionField,
                        sessionId: session.sessionId,
                        sessionText: "",
                        sessionTitle: session.sessionTitle),
                    cvId,
                    lang);
              },
            ),
          )..show(context1);
        },
        onTap: () {
          showDialog(
              context: context1,
              builder: (context) {
                return new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Container(
                      padding: EdgeInsets.all(6),
                      child: Text(
                          AppLocalizations.of(context)
                              .translate("scr006.updateSectionTextTitle"),
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primaryDarkColor,
                          )),
                    ),
                    content: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            filled: true,
                            fillColor:
                                AppColors.primaryDarkColor.withOpacity(0.2),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: new BorderSide(color: Colors.teal)),
                            suffixStyle: TextStyle(color: Colors.green)),
                        maxLines: 10,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        controller: _controller,
                        onChanged: (value) {
                          value.isEmpty ? _validate = true : _validate = false;
                        }),
                    actions: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: FlatButton(
                            child: new Text(
                              AppLocalizations.of(context)
                                  .translate("scr006.btnCancel"),
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () => Navigator.of(context).pop()),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(6),
                        child: new FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: AppColors.primaryDarkColor,
                                )),
                            onPressed: () {
                              sessionUpdate = Session(
                                  icon: session.icon,
                                  sessionField: session.sessionField,
                                  sessionId: session.sessionId,
                                  sessionText: _controller.text,
                                  sessionTitle: session.sessionTitle);
                              BlocProvider.of<LoadCVDetailBloc>(context1)
                                ..add(UpdateSessionEvent(
                                    sessionUpdate, cvId, lang));
                              Navigator.of(context).pop();
                            },
                            child: new Text(
                                AppLocalizations.of(context)
                                    .translate("scr006.btnUpdate"),
                                style: TextStyle(
                                    color: AppColors.primaryDarkColor))),
                      ),
                    ]);
              });
        },
        child: Text(
          session.sessionText,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            color: AppColors.primaryTextColor,
          ),
        ),
      ));
}

Widget buildSessionField(BuildContext context1, Field field, Session session,
    int cvId, String lang) {
  if (field.fieldName.length == 0) {
    return Container(
      color: Color(0x008147),
      width: displayWidth(context1),
      margin: EdgeInsets.fromLTRB(13, 7, 13, 0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text(
            field.fieldText,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),
          ),
        ],
      ),
    );
  } else {
    return GestureDetector(
      onLongPress: () {
        // final snackBar = SnackBar(
        //   content: IconButton(
        //       icon: Icon(Icons.delete),
        //       onPressed: () => showConfirm(
        //           session.sessionId,
        //           context1,
        //           cvId,
        //           AppLocalizations.of(context1)
        //               .translate("scr006.confirmDeleteField"),
        //           field.fieldId,
        //           lang)),
        // );
        // Scaffold.of(context1).showSnackBar(snackBar);
        showDefaultSnackbar(
          context1,
          session.sessionId,
          cvId,
          field.fieldId,
          lang,
          AppLocalizations.of(context1).translate("scr006.confirmDeleteField"),
        );
      },
      child: Container(
          width: displayWidth(context1),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(13, 7, 13, 0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildFieldName(context1, field, session, cvId, lang),
              SizedBox(
                height: 8,
              ),
              buildFieldText(context1, field, session, cvId, lang),
            ],
          )),
    );
  }
}

Widget buildFieldName(BuildContext context1, Field field, Session session,
    int cvId, String lang) {
  TextEditingController _controller = TextEditingController();
  bool _isButtonDisabled = false;
  Field fieldUpdate;
  _controller.text = field.fieldName;
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context1,
          builder: (context) {
            return new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Container(
                  padding: EdgeInsets.all(6),
                  child: Text(
                      AppLocalizations.of(context)
                          .translate("scr006.updateFieldTitle"),
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryDarkColor,
                      )),
                ),
                content: new TextField(
                    autofocus: true,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryDarkColor,
                        fontWeight: FontWeight.bold),
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryDarkColor),
                      ),
                    ),
                    onChanged: (value) {
                      value.isEmpty
                          ? _isButtonDisabled = true
                          : _isButtonDisabled = false;
                    }),
                actions: <Widget>[
                  Container(
                      margin: EdgeInsets.all(5),
                      child: FlatButton(
                          child: new Text(
                            AppLocalizations.of(context)
                                .translate("scr006.btnCancel"),
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () => Navigator.of(context).pop())),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(3),
                    child: new FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: AppColors.primaryDarkColor,
                            )),
                        onPressed: () {
                          if (_isButtonDisabled == true) {
                            //show error
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return new AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      title: Text(
                                        AppLocalizations.of(context)
                                            .translate("scr006.errorEmpty"),
                                        style: TextStyle(
                                            color: AppColors.primaryTextColor),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "scr006.btnUnderStood"),
                                            style: TextStyle(
                                                color: Colors.red[300]),
                                          ),
                                          onPressed: () => {
                                            _controller..text = field.fieldName,
                                            _isButtonDisabled = false,
                                            Navigator.of(context).pop()
                                          },
                                        )
                                      ]);
                                });
                          } else {
                            fieldUpdate = Field(
                                fieldId: field.fieldId,
                                fieldName: _controller.text,
                                fieldText: field.fieldText);
                            BlocProvider.of<LoadCVDetailBloc>(context1)
                              ..add(UpdateFieldEvent(
                                  session.sessionId, cvId, fieldUpdate, lang));
                            Navigator.of(context).pop();
                          }
                        },
                        child: new Text(
                            AppLocalizations.of(context)
                                .translate("scr006.btnUpdate"),
                            style:
                                TextStyle(color: AppColors.primaryDarkColor))),
                  ),
                ]);
          });
    },
    child: Text(
      field.fieldName,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildFieldText(BuildContext context1, Field field, Session session,
    int cvId, String lang) {
  TextEditingController _controller = TextEditingController();
  bool _validate = false;
  Field fieldUpdate;
  _controller.text = field.fieldText;
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context1,
          builder: (context) {
            return new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Container(
                  padding: EdgeInsets.all(6),
                  child: Text(
                      AppLocalizations.of(context)
                          .translate("scr006.updateFieldText"),
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryDarkColor,
                      )),
                ),
                content: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        filled: true,
                        fillColor: AppColors.primaryDarkColor.withOpacity(0.2),
                        border: new OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: new BorderSide(color: Colors.teal)),
                        suffixStyle: TextStyle(color: Colors.green)),
                    maxLines: 10,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: _controller,
                    onChanged: (value) {
                      value.isEmpty ? _validate = true : _validate = false;
                    }),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: FlatButton(
                        child: new Text(
                          AppLocalizations.of(context)
                              .translate("scr006.btnCancel"),
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () => Navigator.of(context).pop()),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(3),
                    child: new FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: AppColors.primaryDarkColor,
                            )),
                        onPressed: () {
                          if (_validate == true) {
                            //show error
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return new AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      title: Text(
                                        AppLocalizations.of(context)
                                            .translate("scr006.errorEmpty"),
                                        style:
                                            TextStyle(color: Colors.red[300]),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "scr006.btnUnderStood"),
                                          ),
                                          onPressed: () => {
                                            _controller
                                              ..text = session.sessionText,
                                            _validate = false,
                                            Navigator.of(context).pop()
                                          },
                                        )
                                      ]);
                                });
                          } else {
                            fieldUpdate = Field(
                              fieldId: field.fieldId,
                              fieldName: field.fieldName,
                              fieldText: _controller.text,
                            );
                            BlocProvider.of<LoadCVDetailBloc>(context1)
                              ..add(UpdateFieldEvent(
                                  session.sessionId, cvId, fieldUpdate, lang));
                            Navigator.of(context).pop();
                          }
                        },
                        child: new Text(
                            AppLocalizations.of(context)
                                .translate("scr006.btnUpdate"),
                            style:
                                TextStyle(color: AppColors.primaryDarkColor))),
                  ),
                ]);
          });
    },
    child: Text(
      field.fieldText,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildCVTitle(BuildContext context1, String title,
    List<Resume> listResume, CVDetail cvDetail, String lang) {
  TextEditingController _controller = TextEditingController();
  _controller..text = title;
  bool _validate = false;
  bool _hadTitle = false;
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        width: displayWidth(context1),
        height: displayHeight(context1) * 0.05,
        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: AppColors.primaryDarkColor,
            width: 1.0,
          )),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: AppColors.primaryDarkColor,
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),
      ),
    ),
    onTap: () {
      showDialog(
          context: context1,
          builder: (context) {
            return new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Container(
                  padding: EdgeInsets.all(6),
                  child: Text(
                      AppLocalizations.of(context)
                          .translate("scr006.updateCVTitle"),
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.bold)),
                ),
                content: new TextField(
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primaryTextColor,
                    ),
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryTextColor),
                      ),
                    ),
                    onChanged: (value) {
                      value.isEmpty ? _validate = true : _validate = false;
                    }),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: FlatButton(
                        child: new Text(
                          AppLocalizations.of(context)
                              .translate("scr006.btnCancel"),
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () => Navigator.of(context).pop()),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(3),
                    child: new FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: AppColors.primaryDarkColor,
                            )),
                        onPressed: () {
                          if (_validate == true) {
                            //show error
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return new AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      title: Text(
                                        AppLocalizations.of(context)
                                            .translate("scr006.errorEmpty"),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    "scr006.btnUnderStood"),
                                            style: TextStyle(
                                                color: Colors.red[300]),
                                          ),
                                          onPressed: () => {
                                            _controller..text = title,
                                            _validate = false,
                                            Navigator.of(context).pop()
                                          },
                                        )
                                      ]);
                                });
                          } else {
                            for (var cv in listResume) {
                              if (cv.title.compareTo(_controller.text) == 0) {
                                _hadTitle = true;
                              }
                            }
                            if (_hadTitle) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        title: Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  "scr006.errorDuplicateCV"),
                                        ),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      "scr006.btnUnderStood"),
                                              style: TextStyle(
                                                  color: Colors.red[300]),
                                            ),
                                            onPressed: () => {
                                              _controller..text = title,
                                              _hadTitle = false,
                                              Navigator.of(context).pop()
                                            },
                                          )
                                        ]);
                                  });
                            } else {
                              Navigator.of(context).pop();

                              BlocProvider.of<LoadCVDetailBloc>(context1).add(
                                  UpdateCVEvent(
                                      CVDetail(
                                          created: cvDetail.created,
                                          cvId: cvDetail.cvId,
                                          employee: cvDetail.employee,
                                          skillsDetail: cvDetail.skillsDetail,
                                          sessions: cvDetail.sessions,
                                          title: _controller.text),
                                      lang));
                              _controller.text = "";
                            }
                          }
                        },
                        child: new Text(
                            AppLocalizations.of(context)
                                .translate("scr006.btnUpdate"),
                            style:
                                TextStyle(color: AppColors.primaryDarkColor))),
                  ),
                ]);
          });
    },
  );
}

Widget buildSessionTitle(
    BuildContext context1, Session session, int cvId, String lang) {
  TextEditingController _controller = TextEditingController();
  bool _validate = false;
  _controller..text = session.sessionTitle;
  Session sessionUpdate;
  return Container(
      width: displayWidth(context1),
      height: displayHeight(context1) * 0.042,
      margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
      // padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: AppColors.primaryDarkColor,
          width: 1.0,
        )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context1,
                  builder: (context) {
                    return new AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: Container(
                          padding: EdgeInsets.all(6),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("scr006.updateSectionTitle"),
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.primaryDarkColor,
                              )),
                        ),
                        content: new TextField(
                            autofocus: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryDarkColor,
                                fontWeight: FontWeight.bold),
                            controller: _controller,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryDarkColor),
                              ),
                            ),
                            onChanged: (value) {
                              value.isEmpty
                                  ? _validate = true
                                  : _validate = false;
                            }),
                        actions: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            child: FlatButton(
                                child: new Text(
                                  AppLocalizations.of(context)
                                      .translate("scr006.btnCancel"),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onPressed: () => Navigator.of(context).pop()),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(3),
                            child: new FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: AppColors.primaryDarkColor,
                                    )),
                                onPressed: () {
                                  if (_validate == true) {
                                    //show error
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return new AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              title: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "scr006.errorEmpty"),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            "scr006.btnUnderStood"),
                                                    style: TextStyle(
                                                        color: Colors.red[300]),
                                                  ),
                                                  onPressed: () => {
                                                    _controller
                                                      ..text =
                                                          session.sessionTitle,
                                                    _validate = false,
                                                    Navigator.of(context).pop()
                                                  },
                                                )
                                              ]);
                                        });
                                  } else {
                                    sessionUpdate = Session(
                                        icon: session.icon,
                                        sessionField: session.sessionField,
                                        sessionId: session.sessionId,
                                        sessionText: session.sessionText,
                                        sessionTitle: _controller.text);
                                    BlocProvider.of<LoadCVDetailBloc>(context1)
                                      ..add(UpdateSessionEvent(
                                          sessionUpdate, cvId, lang));
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: new Text(
                                    AppLocalizations.of(context)
                                        .translate("scr006.btnUpdate"),
                                    style: TextStyle(
                                        color: AppColors.primaryDarkColor))),
                          ),
                        ]);
                  });
            },
            child: Text(
              session.sessionTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryDarkColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Wrap(
              // space between two icons
              children: <Widget>[
                GestureDetector(
                    onTap: () => showDefaultSnackbar(
                          context1,
                          session.sessionId,
                          cvId,
                          -1,
                          lang,
                          AppLocalizations.of(context1)
                              .translate("scr006.confirmDeleteSection"),
                        ),
                    child: SvgPicture.asset(
                      "assets/screens/scr003/bin.svg",
                      width: 20,
                      color: AppColors.primaryDarkColor,
                    ))
              ],
            ),
          ),
        ],
      ));
}

// void showConfirm(int sessionId, BuildContext context1, int cvId, String message,
//     int fieldID, String lang) {
//   showDialog(
//       context: context1,
//       builder: (context) {
//         return new AlertDialog(
//             title: new Text(message),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20.0))),
//             actions: <Widget>[
//               new FlatButton(
//                   child: new Text(
//                     AppLocalizations.of(context).translate("scr006.btnCancel"),
//                     style: TextStyle(
//                       color: AppColors.primaryTextColor.withOpacity(0.5),
//                     ),
//                   ),
//                   onPressed: () => Navigator.of(context).pop()),
//               new FlatButton(
//                   child: new Text(
//                     AppLocalizations.of(context).translate("scr006.btnDelete"),
//                     style: TextStyle(
//                         color: Colors.red[300], fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () {
//                     onDelete(context1, sessionId, cvId, fieldID, lang);
//                     Navigator.of(context).pop();
//                   })
//             ]);
//       });
// }

// void onDelete(context1, int sessionId, int cvId, int fieldId, String lang) {
//   if (fieldId < 0) {
//     //no fieldId -> delete session
//     BlocProvider.of<LoadCVDetailBloc>(context1)
//       ..add(DeleteSessionEvent(cvId: cvId, sessionId: sessionId, lang: lang));
//   } else {
//     BlocProvider.of<LoadCVDetailBloc>(context1).add(DeleteFieldEvent(
//         cvId: cvId, fieldId: fieldId, sessionId: sessionId, lang: lang));
//   }
// }

void updateSessionText(
    BuildContext context1, Session sessionUpdate, int cvId, String lang) {
  BlocProvider.of<LoadCVDetailBloc>(context1)
    ..add(UpdateSessionEvent(sessionUpdate, cvId, lang));
}

void showDefaultSnackbar(BuildContext context1, int sessionId, int cvId,
    int fieldId, String lang, String message) {
  Flushbar(
    margin: EdgeInsets.fromLTRB(5, 5, 5, 70),
    borderRadius: 8,
    duration: Duration(seconds: 3),
    backgroundColor: AppColors.secondaryLightColor,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    messageText: Container(
      padding: EdgeInsets.only(left: 50),
      child: Text(
        message,
        style: TextStyle(color: AppColors.primaryDarkColor),
      ),
    ),
    mainButton: FlatButton(
      child: Container(
        width: displayWidth(context1) * 0.25,
        height: 20,
        child: Center(
          child: Icon(Icons.delete, color: AppColors.primaryDarkColor),
        ),
      ),
      onPressed: () {
        if (fieldId < 0) {
          //no fieldId -> delete session
          BlocProvider.of<LoadCVDetailBloc>(context1)
            ..add(DeleteSessionEvent(
                cvId: cvId, sessionId: sessionId, lang: lang));
        } else {
          BlocProvider.of<LoadCVDetailBloc>(context1).add(DeleteFieldEvent(
              cvId: cvId, fieldId: fieldId, sessionId: sessionId, lang: lang));
        }
      },
    ),
  )..show(context1);
}
