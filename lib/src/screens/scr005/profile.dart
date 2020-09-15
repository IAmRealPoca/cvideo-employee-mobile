/*
 * File: profile.dart
 * Project: CVideo
 * File Created: Saturday, 11th July 2020 4:49:14 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 11th July 2020 4:49:22 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _spaceBetweenTitle = 20.0;
    final double _spaceBetweenTextFormField = 15.0;

    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.UPDATE_EMPLOYEE_SCREEN,
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.edit),
        elevation: 2.0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child:
            BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
          if (state is EmployeeInforFetchedSuccess) {
            return Stack(
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
                            height: size.height * 0.73,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 48),
                              child: SingleChildScrollView(
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, left: 2),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      //show employee's full name
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("scr005.fullName"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.primaryDarkColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _spaceBetweenTextFormField,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(state.employee.fullName),
                                        //validation
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
                                            AppLocalizations.of(context)
                                                .translate("scr005.dob"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.primaryDarkColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _spaceBetweenTextFormField,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(DateFormat("yyyy-MM-dd")
                                            .format(
                                                state.employee.dateOfBirth)),
                                        //validation
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
                                            AppLocalizations.of(context)
                                                .translate("scr005.phone"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.primaryDarkColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _spaceBetweenTextFormField,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(state.employee.phone),
                                        //validation
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
                                            AppLocalizations.of(context)
                                                .translate("scr005.gender"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.primaryDarkColor),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            state.employee.gender == "Male"
                                                ? AppLocalizations.of(context)
                                                    .translate("scr005.male")
                                                : AppLocalizations.of(context)
                                                    .translate("scr005.female"),
                                            style: TextStyle(fontSize: 16.0),
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
                                            AppLocalizations.of(context)
                                                .translate("scr005.address"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.primaryDarkColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _spaceBetweenTextFormField,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          state.employee.address,
                                          overflow: TextOverflow.clip,
                                        ),
                                        //validation
                                      ),
                                      SizedBox(
                                        height: _spaceBetweenTitle,
                                      ),
                                      SizedBox(
                                        height: _spaceBetweenTextFormField,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: (size.width / 2) - 60,
                          child: Container(
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: state.employee.avatar.isEmpty
                                  ? AssetImage("assets/screens/scr002/user.png")
                                  : NetworkImage(state.employee.avatar),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primaryDarkColor),
              ),
            ),
          );
        }),
      ),
    );
  }
}
