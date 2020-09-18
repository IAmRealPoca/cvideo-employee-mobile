/*
 * File: profile.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 1:12:47 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 1:48:40 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/models/scr005/employee_profile.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr005/update_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  DateTime selectedData;
  final double _spaceBetweenTitle = 20.0;
  final double _spaceBetweenTextFormField = 15.0;
  bool _validateFullName = false;
  bool _validateAddress = false;
  bool _validatePhoneNumber = false;
  int _radioValue;
  bool isCheck = false;
  String _result = "Male";
  EmployeeProfile employeeProfile = EmployeeProfile();
  bool _checkLast = false;
  void _handleRadioValueChange(int value) {
    isCheck = true;
    switch (value) {
      case 0:
        _result = "Male";
        employeeProfile.gender = _result;
        break;
      case 1:
        _result = "Female";
        employeeProfile.gender = _result;
        break;
    }
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        return EmployeeBloc(employeeRepository: EmployeeRepository())
          ..add(EmployeeFetched());
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeInforFetchedSuccess) {
            if (!isCheck) {
              if (state.employee.gender == "Male") {
                _radioValue = 0;
              } else {
                _radioValue = 1;
              }
            }
            employeeProfile.accountId = state.employee.id;
            employeeProfile.fullName = state.employee.fullName;
            if (state.employee.address == null) {
              employeeProfile.address = "";
            } else {
              employeeProfile.address = state.employee.address;
            }
            employeeProfile.dateOfBirth = state.employee.dateOfBirth;
            if (state.employee.phone == null) {
              employeeProfile.phoneNumber = "";
            } else {
              employeeProfile.phoneNumber = state.employee.phone;
            }
            employeeProfile.gender = _result;
            employeeProfile.avatar = state.employee.avatar;
            return Scaffold(
                resizeToAvoidBottomInset: true,
                resizeToAvoidBottomPadding: false,
                body: SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      child: Stack(
                        children: <Widget>[
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
                              height: size.height * 0.935,
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
                                      height: size.height * 0.76,
                                      width: size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 48),
                                        child: SingleChildScrollView(
                                          reverse: true,
                                          scrollDirection: Axis.vertical,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 2),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                //show employee's full name
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.fullName"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryDarkColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      _spaceBetweenTextFormField,
                                                ),
                                                TextField(
                                                  controller: new TextEditingController
                                                          .fromValue(
                                                      new TextEditingValue(
                                                          text: state.employee
                                                              .fullName,
                                                          selection:
                                                              new TextSelection
                                                                      .collapsed(
                                                                  offset: state
                                                                      .employee
                                                                      .fullName
                                                                      .length))),
                                                  decoration:
                                                      new InputDecoration(
                                                    errorText: _validateFullName
                                                        ? AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr005.errFullName")
                                                        : null,
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        const Radius.circular(
                                                            20),
                                                      ),
                                                    ),
                                                    hintText: AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr005.labelFullName"),
                                                    labelText: AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr005.fullName"),
                                                  ),
                                                  //validation
                                                  onChanged: (value) {
                                                    if (value.isEmpty) {
                                                      _validateFullName = true;
                                                    }
                                                    if (value.isNotEmpty) {
                                                      _validateFullName = false;
                                                      state.employee.fullName =
                                                          value;
                                                      employeeProfile.fullName =
                                                          state.employee
                                                              .fullName;
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  height: _spaceBetweenTitle,
                                                ),

                                                //show employee's date of birth
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.dob"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryDarkColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      _spaceBetweenTextFormField,
                                                ),
                                                DateField(
                                                  onDateSelected:
                                                      (DateTime value) {
                                                    setState(() {
                                                      state.employee
                                                          .dateOfBirth = value;
                                                      employeeProfile
                                                              .dateOfBirth =
                                                          state.employee
                                                              .dateOfBirth;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        const Radius.circular(
                                                            20),
                                                      ),
                                                    ),
                                                  ),
                                                  label: AppLocalizations.of(
                                                          context)
                                                      .translate("scr005.dob"),
                                                  firstDate:
                                                      DateTime(1900, 1, 1),
                                                  lastDate:
                                                      DateTime(2022, 3, 20),
                                                  dateFormat:
                                                      DateFormat("yyyy-MM-dd"),
                                                  selectedDate: state
                                                      .employee.dateOfBirth,
                                                ),
                                                SizedBox(
                                                  height: _spaceBetweenTitle,
                                                ),

                                                //show employee's phone number
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.phone"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryDarkColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      _spaceBetweenTextFormField,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    errorText: _validatePhoneNumber
                                                        ? AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr005.errPhone")
                                                        : null,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                const Radius
                                                                        .circular(
                                                                    20))),
                                                    hintText: AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr005.labelPhone"),
                                                    labelText:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr005.phone"),
                                                  ),
                                                  controller: new TextEditingController
                                                          .fromValue(
                                                      new TextEditingValue(
                                                          text: state
                                                              .employee.phone,
                                                          selection:
                                                              new TextSelection
                                                                      .collapsed(
                                                                  offset: state
                                                                      .employee
                                                                      .phone
                                                                      .length))),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  onChanged: (value) {
                                                    if (value.length != 10) {
                                                      _validatePhoneNumber =
                                                          true;
                                                    }
                                                    if (value.length == 10) {
                                                      _validatePhoneNumber =
                                                          false;
                                                    }
                                                    state.employee.phone =
                                                        value;
                                                    employeeProfile
                                                            .phoneNumber =
                                                        state.employee.phone;
                                                  },
                                                ),

                                                SizedBox(
                                                  height: _spaceBetweenTitle,
                                                ),

                                                //show employee's gender

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.gender"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryDarkColor),
                                                    ),
                                                    new Radio(
                                                      value: 0,
                                                      groupValue: _radioValue,
                                                      onChanged:
                                                          _handleRadioValueChange,
                                                    ),
                                                    new Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.male"),
                                                      style: new TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                    new Radio(
                                                      value: 1,
                                                      groupValue: _radioValue,
                                                      onChanged:
                                                          _handleRadioValueChange,
                                                    ),
                                                    new Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.female"),
                                                      style: new TextStyle(
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: _spaceBetweenTitle,
                                                ),

                                                //show employee's address
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "scr005.address"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryDarkColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      _spaceBetweenTextFormField,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    errorText: _validateAddress
                                                        ? AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "scr005.errAddress")
                                                        : null,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                const Radius
                                                                        .circular(
                                                                    20))),
                                                    hintText: AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr005.labelAddress"),
                                                    labelText: AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            "scr005.address"),
                                                  ),
                                                  controller: new TextEditingController
                                                          .fromValue(
                                                      new TextEditingValue(
                                                          text: state
                                                              .employee.address,
                                                          selection:
                                                              new TextSelection
                                                                      .collapsed(
                                                                  offset: state
                                                                      .employee
                                                                      .address
                                                                      .length))),
                                                  maxLines: null,
                                                  onChanged: (value) {
                                                    if (value.length == 0) {
                                                      _validateAddress = true;
                                                    } else {
                                                      _validateAddress = false;
                                                      state.employee.address =
                                                          value;
                                                      employeeProfile.address =
                                                          state
                                                              .employee.address;
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  height: _spaceBetweenTitle,
                                                ),
                                                SizedBox(
                                                  height:
                                                      _spaceBetweenTextFormField,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 74,
                                    left: (size.width / 2) - 60,
                                    child: Container(
                                      child: CircleAvatar(
                                        radius: 65,
                                        backgroundImage: state
                                                .employee.avatar.isEmpty
                                            ? AssetImage(
                                                "assets/screens/scr002/user.png")
                                            : NetworkImage(
                                                state.employee.avatar),
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
                  ),
                ),
                bottomNavigationBar: BlocProvider(
                  create: (context) {
                    return UpdateEmployeeInfoBloc(
                        employeeRepository: EmployeeRepository());
                  },
                  child: BlocBuilder<UpdateEmployeeInfoBloc,
                      UpdateEmployeeInfoState>(builder: (context, state) {
                    if (state is UpdateEmployeeInfoInitial) {
                      return UpdateButton(
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _checkLast = checkLast(employeeProfile);
                          if (_checkLast) {
                            showAlertDialog(context, employeeProfile);
                          } else {
                            showAlertInvalidDialog(context);
                          }
                        },
                      );
                    }
                    if (state is UpdateEmployeeInfoProcessing) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryDarkColor),
                          ),
                        ),
                      );
                    }
                    if (state is UpdateEmployeeInfoSuccess) {
                      SchedulerBinding.instance.addPostFrameCallback((_) async {
                        Navigator.of(context).popUntil((route) {
                          return route.settings.name == AppRoutes.SCR002_SCREEN;
                        });
                      });
                    }
                    if (state is UpdateEmployeeInfoFailure) {
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
                          valueColor: AlwaysStoppedAnimation(
                              AppColors.primaryDarkColor),
                        ),
                      ),
                    );
                  }),
                ));
          }
          return Container(
            color: Colors.white,
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
    );
  }

  showAlertDialog(BuildContext context, EmployeeProfile employeeProfile) {
    // Create button
    Widget yesButton = FlatButton(
      child: Text(
        AppLocalizations.of(context).translate("scr005.yes"),
        style: TextStyle(color: AppColors.primaryDarkColor, fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
        BlocProvider.of<UpdateEmployeeInfoBloc>(context)
          ..add(UpdateEmployeeInfoRequest(employeeProfile: employeeProfile));
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
        AppLocalizations.of(context).translate("scr005.confirmUpdate"),
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

//show dialog if something invalid with information
  showAlertInvalidDialog(BuildContext context) {
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
        AppLocalizations.of(context).translate("scr005.attentionMsg"),
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

  bool checkLast(EmployeeProfile employeeProfile) {
    if (employeeProfile.fullName.isEmpty) {
      return false;
    }
    if (employeeProfile.phoneNumber.length != 10) {
      return false;
    }
    if (employeeProfile.gender.isEmpty) {
      return false;
    }
    if (employeeProfile.address.isEmpty) {
      return false;
    }
    return true;
  }
}
