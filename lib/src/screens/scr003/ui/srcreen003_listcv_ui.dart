import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/models.dart';
import 'package:cvideo_mobile/src/screens/scr006/screen006.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'BoxDecoration.dart';
import 'sizes_helpers.dart';

Widget buildListResume(
    List<Resume> listResume, BuildContext context, String lang) {
  return new ListView.builder(
    itemCount: listResume.length,
    itemBuilder: (context, index) {
      if (index == 0) {
        return buildResumeItemFirst(
            listResume[index], context, listResume, lang);
      }
      if (index == listResume.length - 1) {
        return buildResumeItemLast(
            listResume[index], context, listResume, lang);
      }
      return buildResumeItem(listResume[index], context, listResume, lang);
    },
  );
}

Widget buildResumeItemFirst(Resume resume, BuildContext context1,
    List<Resume> listResume, String lang) {
  var datetime =
      DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.parse(resume.created));
  DateFormat format = new DateFormat("dd-MM-yyyy hh:mm:ss");
  DateTime time = format.parse(datetime);
  var days = time.day.toString();
  var day = days;
  if (days.length < 2) {
    day = "0" + days;
  }
  var months = time.month.toString();
  var month = months;
  if (months.length < 2) {
    month = "0" + months;
  }
  var year = time.year;
  var hours = (time.hour + 7).toString();
  var hour = hours;
  if (hours.length < 2) {
    hour = "0" + hours;
  }
  var minue = time.minute.toString();
  var minues = minue;
  if (minue.length < 2) {
    minues = "0" + minue;
  }
  var seconds = time.second.toString();
  var second = seconds;
  if (seconds.length < 2) {
    second = "0" + seconds;
  }
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 7, 8, 0),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(

          // margin: EdgeInsets.fromLTRB(8, 10, 10, 10),
          margin: EdgeInsets.only(top: 5),
          decoration: resumeBoxDecoration(),
          width: displayWidth(context1),
          height: displayHeight(context1) * 0.14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: resumeBoxDecoration(),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(0, 3, 3, 3),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: SvgPicture.asset(
                  'assets/screens/scr003/cv_color.svg',
                  width: displayWidth(context1) * 0.03,
                  height: 90,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: resumeBoxDecoration(),
                  width: displayWidth(context1) * 0.67,
                  padding: EdgeInsets.only(top: 8),
                  height: 100,
                  margin: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Title(
                              color: AppColors.primaryDarkColor,
                              child: Text(
                                resume.title,
                                style: TextStyle(
                                    color: AppColors.primaryDarkColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/screens/scr003/clock.svg',
                            width: displayWidth(context1) * 0.01,
                            height: 12,
                            color: AppColors.primaryTextColor.withOpacity(0.5),
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            day.toString() +
                                "-" +
                                month.toString() +
                                "-" +
                                year.toString() +
                                " " +
                                hour.toString() +
                                ":" +
                                minues.toString() +
                                ":" +
                                second.toString(),
                            style: TextStyle(
                              color:
                                  AppColors.primaryTextColor.withOpacity(0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 3, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.5),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SizedBox(
                                    width: 90,
                                    height: 25,
                                    child: FlatButton.icon(
                                      icon: SvgPicture.asset(
                                        'assets/screens/scr003/eye.svg',
                                        width: 13,
                                        color: AppColors.primaryDarkColor,
                                      ),
                                      label: Text(
                                          AppLocalizations.of(context1)
                                              .translate("scr003.btnDetail"),
                                          style: TextStyle(
                                            color: AppColors.primaryDarkColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      onPressed: () {
                                        Navigator.of(context1)
                                            .pushNamed(AppRoutes.SCR006_SCREEN,
                                                arguments: ScreenArguments(
                                                  cvId: resume.cvId.toString(),
                                                  titleCV: resume.title,
                                                  listResume: listResume,
                                                  contextList: context1,
                                                ));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.5),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SizedBox(
                                    width: 85,
                                    height: 25,
                                    child: FlatButton.icon(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 13,
                                        color: AppColors.primaryDarkColor,
                                      ),
                                      label: Text(
                                          AppLocalizations.of(context1)
                                              .translate("scr003.btnDelete"),
                                          style: TextStyle(
                                            color: AppColors.primaryDarkColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      onPressed: () {
                                        showConfirm(context1,
                                            resume.cvId.toString(), lang);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    ),
  );
}

Widget buildResumeItem(Resume resume, BuildContext context1,
    List<Resume> listResume, String lang) {
  var datetime =
      DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.parse(resume.created));
  DateFormat format = new DateFormat("dd-MM-yyyy hh:mm:ss");
  DateTime time = format.parse(datetime);
  var days = time.day.toString();
  var day = days;
  if (days.length < 2) {
    day = "0" + days;
  }
  var months = time.month.toString();
  var month = months;
  if (months.length < 2) {
    month = "0" + months;
  }
  var year = time.year;
  var hours = (time.hour + 7).toString();
  var hour = hours;
  if (hours.length < 2) {
    hour = "0" + hours;
  }
  var minue = time.minute.toString();
  var minues = minue;
  if (minue.length < 2) {
    minues = "0" + minue;
  }
  var seconds = time.second.toString();
  var second = seconds;
  if (seconds.length < 2) {
    second = "0" + seconds;
  }
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
          // margin: EdgeInsets.fromLTRB(8, 10, 10, 10),
          margin: EdgeInsets.only(top: 5),
          decoration: resumeBoxDecoration(),
          width: displayWidth(context1),
          height: displayHeight(context1) * 0.14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: resumeBoxDecoration(),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(0, 3, 3, 3),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: SvgPicture.asset(
                  'assets/screens/scr003/cv_color.svg',
                  width: displayWidth(context1) * 0.03,
                  height: 90,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: resumeBoxDecoration(),
                  width: displayWidth(context1) * 0.67,
                  padding: EdgeInsets.only(top: 8),
                  height: 100,
                  margin: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Title(
                              color: AppColors.primaryDarkColor,
                              child: Text(
                                resume.title,
                                style: TextStyle(
                                    color: AppColors.primaryDarkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/screens/scr003/clock.svg',
                            width: displayWidth(context1) * 0.01,
                            height: 12,
                            color: AppColors.primaryTextColor.withOpacity(0.5),
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            day.toString() +
                                "-" +
                                month.toString() +
                                "-" +
                                year.toString() +
                                " " +
                                hour.toString() +
                                ":" +
                                minues +
                                ":" +
                                second.toString(),
                            style: TextStyle(
                              color:
                                  AppColors.primaryTextColor.withOpacity(0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 3, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.5),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SizedBox(
                                    width: 90,
                                    height: 25,
                                    child: FlatButton.icon(
                                      icon: SvgPicture.asset(
                                        'assets/screens/scr003/eye.svg',
                                        width: displayWidth(context1) * 0.01,
                                        height: 13,
                                        color: AppColors.primaryDarkColor,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      label: Text(
                                          AppLocalizations.of(context1)
                                              .translate("scr003.btnDetail"),
                                          style: TextStyle(
                                            color: AppColors.primaryDarkColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      onPressed: () {
                                        Navigator.of(context1)
                                            .pushNamed(AppRoutes.SCR006_SCREEN,
                                                arguments: ScreenArguments(
                                                  cvId: resume.cvId.toString(),
                                                  titleCV: resume.title,
                                                  listResume: listResume,
                                                  contextList: context1,
                                                ));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.5),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SizedBox(
                                    width: 85,
                                    height: 25,
                                    child: FlatButton.icon(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 13,
                                        color: AppColors.primaryDarkColor,
                                      ),
                                      label: Text(
                                          AppLocalizations.of(context1)
                                              .translate("scr003.btnDelete"),
                                          style: TextStyle(
                                            color: AppColors.primaryDarkColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      onPressed: () {
                                        showConfirm(context1,
                                            resume.cvId.toString(), lang);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    ),
  );
}

Widget buildResumeItemLast(Resume resume, BuildContext context1,
    List<Resume> listResume, String lang) {
  var datetime =
      DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.parse(resume.created));
  DateFormat format = new DateFormat("dd-MM-yyyy hh:mm:ss");
  DateTime time = format.parse(datetime);
  var days = time.day.toString();
  var day = days;
  if (days.length < 2) {
    day = "0" + days;
  }
  var months = time.month.toString();
  var month = months;
  if (months.length < 2) {
    month = "0" + months;
  }
  var year = time.year;
  var hours = (time.hour + 7).toString();
  var hour = hours;
  if (hours.length < 2) {
    hour = "0" + hours;
  }
  var minue = time.minute.toString();
  var minues = minue;
  if (minue.length < 2) {
    minues = "0" + minue;
  }
  var seconds = time.second.toString();
  var second = seconds;
  if (seconds.length < 2) {
    second = "0" + seconds;
  }
  return Container(
    margin: EdgeInsets.only(bottom: 80),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
            // margin: EdgeInsets.fromLTRB(8, 10, 10, 10),
            margin: EdgeInsets.only(top: 5),
            decoration: resumeBoxDecoration(),
            width: displayWidth(context1),
            height: displayHeight(context1) * 0.14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: resumeBoxDecoration(),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 3, 3, 3),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: SvgPicture.asset(
                    'assets/screens/scr003/cv_color.svg',
                    width: displayWidth(context1) * 0.03,
                    height: 90,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: resumeBoxDecoration(),
                    width: displayWidth(context1) * 0.67,
                    padding: EdgeInsets.only(top: 8),
                    height: 100,
                    margin: EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Title(
                                color: AppColors.primaryDarkColor,
                                child: Text(
                                  resume.title,
                                  style: TextStyle(
                                      color: AppColors.primaryDarkColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/screens/scr003/clock.svg',
                              width: displayWidth(context1) * 0.01,
                              height: 12,
                              color:
                                  AppColors.primaryTextColor.withOpacity(0.5),
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              day.toString() +
                                  "-" +
                                  month.toString() +
                                  "-" +
                                  year.toString() +
                                  " " +
                                  hour.toString() +
                                  ":" +
                                  minues +
                                  ":" +
                                  second.toString(),
                              style: TextStyle(
                                color:
                                    AppColors.primaryTextColor.withOpacity(0.5),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 3, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryDarkColor
                                            .withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      width: 90,
                                      height: 25,
                                      child: FlatButton.icon(
                                        icon: SvgPicture.asset(
                                          'assets/screens/scr003/eye.svg',
                                          width: displayWidth(context1) * 0.01,
                                          height: 13,
                                          color: AppColors.primaryDarkColor,
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                        label: Text(
                                            AppLocalizations.of(context1)
                                                .translate("scr003.btnDetail"),
                                            style: TextStyle(
                                              color: AppColors.primaryDarkColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        onPressed: () {
                                          Navigator.of(context1).pushNamed(
                                              AppRoutes.SCR006_SCREEN,
                                              arguments: ScreenArguments(
                                                cvId: resume.cvId.toString(),
                                                titleCV: resume.title,
                                                listResume: listResume,
                                                contextList: context1,
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryDarkColor
                                            .withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SizedBox(
                                      width: 85,
                                      height: 25,
                                      child: FlatButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 13,
                                          color: AppColors.primaryDarkColor,
                                        ),
                                        label: Text(
                                            AppLocalizations.of(context1)
                                                .translate("scr003.btnDelete"),
                                            style: TextStyle(
                                              color: AppColors.primaryDarkColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        onPressed: () {
                                          showConfirm(context1,
                                              resume.cvId.toString(), lang);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    ),
  );
}

Widget buildSuccessScreen(BuildContext context, List<Resume> listResume,
    List<MajorDetail> listMajorDetail, String lang) {
  int dropdownValue;
  var buildContext = context;
  dropdownValue = dropdownValue ?? listMajorDetail[0].majorId;
  TextEditingController _controllerTitle = TextEditingController();
  return Scaffold(
      body: Container(
        child: buildListResume(listResume, context, lang),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool _validate = true;
          bool _hasTitle = false;
          List<DropdownMenuItem<int>> _dropdownMenuItem = List();
          for (MajorDetail major in listMajorDetail) {
            _dropdownMenuItem.add(DropdownMenuItem<int>(
              value: major.majorId,
              child: Text(major.majorName),
            ));
          }

          showDialog(
              context: buildContext,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text(
                      AppLocalizations.of(context).translate("scr003.createCV"),
                      style: TextStyle(color: AppColors.primaryDarkColor),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    actions: <Widget>[
                      //button of dialog
                      Container(
                        margin: EdgeInsets.all(5),
                        child: FlatButton(
                            child: new Text(
                              AppLocalizations.of(context)
                                  .translate("scr003.btnCancel"),
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () => Navigator.of(context).pop()),
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
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: AppColors.primaryDarkColor,
                                )),
                            child: new Text(
                              AppLocalizations.of(context)
                                  .translate("scr003.btnCreateCV"),
                              style:
                                  TextStyle(color: AppColors.primaryDarkColor),
                            ),
                            onPressed: () => {
                                  if (_validate == true)
                                    {
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
                                                title: Text(AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        "scr003.errorEmptyCV")),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr003.btnUnderStood"),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[300]),
                                                    ),
                                                    onPressed: () => {
                                                      _validate = false,
                                                      Navigator.of(context)
                                                          .pop()
                                                    },
                                                  )
                                                ]);
                                          })
                                    }
                                  else
                                    {
                                      for (var cv in listResume)
                                        {
                                          if (cv.title.compareTo(
                                                  _controllerTitle.text) ==
                                              0)
                                            {
                                              _hasTitle = true,
                                            }
                                        },
                                      if (!_hasTitle)
                                        {
                                          BlocProvider.of<LoadListCVBloc>(
                                              buildContext)
                                            ..add(AddNewCVEvent(
                                                cvTitle: _controllerTitle.text,
                                                majorId: dropdownValue,
                                                lang: lang)),
                                          Navigator.of(context).pop(),
                                          _controllerTitle.text = "",
                                        }
                                      else
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (loadListCVBlocContext) {
                                                return new AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    title: Text(AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr003.errorDuplicateCV")),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  "scr003.btnUnderStood"),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red[300]),
                                                        ),
                                                        onPressed: () => {
                                                          _hasTitle = false,
                                                          _validate = true,
                                                          Navigator.of(context)
                                                              .pop()
                                                        },
                                                      )
                                                    ]);
                                              }),
                                        }
                                    }
                                }),
                      ),
                    ],
                    content: Builder(
                      builder: (context) {
                        //place to input
                        return Container(
                          // color: Colors.amber,
                          margin: EdgeInsets.only(top: 20),
                          width: displayWidth(context),
                          height: displayHeight(context) * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: _controllerTitle,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                    hintText: AppLocalizations.of(context)
                                        .translate("scr003.hintTextCV"),
                                    helperText: AppLocalizations.of(context)
                                        .translate("scr003.helpTextCV"),
                                    labelText: AppLocalizations.of(context)
                                        .translate("scr003.labelTextCV"),
                                    prefixIcon: Icon(
                                      Icons.title,
                                      color: AppColors.primaryDarkColor,
                                    ),
                                    prefixText: ' ',
                                    suffixStyle: TextStyle(
                                      color: AppColors.primaryDarkColor,
                                    )),
                                //validation
                                onChanged: (value) {
                                  value.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("scr003.chooseMajor"),
                                      style: TextStyle(
                                          color: AppColors.primaryTextColor
                                              .withOpacity(0.5),
                                          fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: displayWidth(context) * 0.25,
                                      child: Center(
                                        child: DropdownButton<int>(
                                          items: _dropdownMenuItem,
                                          value: dropdownValue,
                                          elevation: 16,
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryDarkColor),
                                          underline: Container(
                                            height: 2,
                                            color: AppColors.primaryDarkColor,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                });
              });
        },
        tooltip: AppLocalizations.of(context).translate("scr003.createCV"),
        child: Icon(Icons.add),
        backgroundColor: AppColors.secondaryLightColor,
      ));
}

Widget buildFailedScreen(
    BuildContext context, String message, List<MajorDetail> listMajorDetail) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 250, 0, 0),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            'assets/screens/scr003/job_seeker.svg',
            width: displayWidth(context) * 0.03,
            height: 90,
            allowDrawingOutsideViewBox: true,
          ),
        ),
        Text(message,
            style: TextStyle(
                color: AppColors.primaryDarkColor,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget buildNoCVScreen(BuildContext context, String message,
    List<MajorDetail> listMajorDetail, List<Resume> listResume, String lang) {
  var buildContext = context;
  int dropdownValue;
  dropdownValue = dropdownValue ?? listMajorDetail[0].majorId;
  TextEditingController _controllerTitle = TextEditingController();
  return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 250, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/screens/scr003/job_seeker.svg',
                width: displayWidth(context) * 0.03,
                height: 90,
                allowDrawingOutsideViewBox: true,
              ),
            ),
            Text(message,
                style: TextStyle(
                    color: AppColors.primaryDarkColor,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool _validate = true;
          bool _hasTitle = false;
          List<DropdownMenuItem<int>> _dropdownMenuItem = List();
          for (MajorDetail major in listMajorDetail) {
            _dropdownMenuItem.add(DropdownMenuItem<int>(
              value: major.majorId,
              child: Text(major.majorName),
            ));
          }

          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text(
                      AppLocalizations.of(context).translate("scr003.createCV"),
                      style: TextStyle(color: AppColors.primaryDarkColor),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    actions: <Widget>[
                      //button of dialog
                      Container(
                        margin: EdgeInsets.all(5),
                        child: FlatButton(
                            child: new Text(
                              AppLocalizations.of(context)
                                  .translate("scr003.btnCancel"),
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () => Navigator.of(context).pop()),
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
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: AppColors.primaryDarkColor,
                                )),
                            child: new Text(
                              AppLocalizations.of(context)
                                  .translate("scr003.btnCreateCV"),
                              style:
                                  TextStyle(color: AppColors.primaryDarkColor),
                            ),
                            onPressed: () => {
                                  if (_validate == true)
                                    {
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
                                                title: Text(AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        "scr003.errorEmptyCV")),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr003.btnUnderStood"),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[300]),
                                                    ),
                                                    onPressed: () => {
                                                      _validate = false,
                                                      Navigator.of(context)
                                                          .pop()
                                                    },
                                                  )
                                                ]);
                                          })
                                    }
                                  else
                                    {
                                      for (var cv in listResume)
                                        {
                                          if (cv.title.compareTo(
                                                  _controllerTitle.text) ==
                                              0)
                                            {
                                              _hasTitle = true,
                                            }
                                        },
                                      if (!_hasTitle)
                                        {
                                          BlocProvider.of<LoadListCVBloc>(
                                              buildContext)
                                            ..add(AddNewCVEvent(
                                                cvTitle: _controllerTitle.text,
                                                majorId: dropdownValue,
                                                lang: lang)),
                                          Navigator.of(context).pop(),
                                          _controllerTitle.text = "",
                                        }
                                      else
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (loadListCVBlocContext) {
                                                return new AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    title: Text(AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr003.errorDuplicateCV")),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  "scr003.btnUnderStood"),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red[300]),
                                                        ),
                                                        onPressed: () => {
                                                          _hasTitle = false,
                                                          _validate = true,
                                                          Navigator.of(context)
                                                              .pop()
                                                        },
                                                      )
                                                    ]);
                                              }),
                                        }
                                    }
                                }),
                      ),
                    ],
                    content: Builder(
                      builder: (context) {
                        //place to input
                        return Container(
                          // color: Colors.amber,
                          margin: EdgeInsets.only(top: 20),
                          width: displayWidth(context),
                          height: displayHeight(context) * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: _controllerTitle,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                    hintText: AppLocalizations.of(context)
                                        .translate("scr003.hintTextCV"),
                                    helperText: AppLocalizations.of(context)
                                        .translate("scr003.helpTextCV"),
                                    labelText: AppLocalizations.of(context)
                                        .translate("scr003.labelTextCV"),
                                    prefixIcon: Icon(
                                      Icons.title,
                                      color: AppColors.primaryDarkColor,
                                    ),
                                    prefixText: ' ',
                                    suffixStyle: TextStyle(
                                      color: AppColors.primaryDarkColor,
                                    )),
                                //validation
                                onChanged: (value) {
                                  value.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("scr003.chooseMajor"),
                                      style: TextStyle(
                                          color: AppColors.primaryTextColor
                                              .withOpacity(0.5),
                                          fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: displayWidth(context) * 0.25,
                                      child: Center(
                                        child: DropdownButton<int>(
                                          items: _dropdownMenuItem,
                                          value: dropdownValue,
                                          elevation: 16,
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryDarkColor),
                                          underline: Container(
                                            height: 2,
                                            color: AppColors.primaryDarkColor,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                });
              });
        },
        tooltip: AppLocalizations.of(context).translate("scr003.createCV"),
        child: Icon(Icons.add),
        backgroundColor: AppColors.secondaryLightColor,
      ));
}

void showConfirm(BuildContext context1, String cvId, String lang) {
  showDialog(
      context: context1,
      builder: (context) {
        return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(AppLocalizations.of(context)
                .translate("scr003.confirmDeleteCV")),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: FlatButton(
                    child: new Text(
                      AppLocalizations.of(context)
                          .translate("scr003.btnCancel"),
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () => Navigator.of(context).pop()),
              ),
              SizedBox(
                width: 9,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: FlatButton(
                  child: new Text(
                    AppLocalizations.of(context).translate("scr003.btnDelete"),
                    style: TextStyle(
                        color: Colors.red[300], fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    onDelete(context1, cvId, lang);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ]);
      });
}

void onDelete(BuildContext context, String cvId, String lang) {
  BlocProvider.of<LoadListCVBloc>(context)
    ..add(DeleteCVEvent(cvId: cvId, lang: lang));
}
