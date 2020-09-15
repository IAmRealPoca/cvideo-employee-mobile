/*
 * File: scr005.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 1:12:40 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 1:13:49 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr005/profile.dart';
import 'package:cvideo_mobile/src/screens/scr005/round_login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SCR005 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Get the [size] of the screen
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationSuccess) {
        return BlocProvider(
          create: (context) {
            return EmployeeBloc(employeeRepository: EmployeeRepository())
              ..add(EmployeeFetched());
          },
          child: Scaffold(
            body: Profile(),
            bottomNavigationBar: AppBottomNavigationBar(
              currentIndex: 2,
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context).translate("scr005.profileTitle")),
          centerTitle: true,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/screens/scr002/background.png",
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate("scr005.profile"),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDarkColor),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)
                        .translate("scr005.profileOnline"),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDarkColor.withOpacity(0.7)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: size.width - 60,
                      child: Text(
                        AppLocalizations.of(context)
                                .translate("scr005.introPart1") +
                            AppLocalizations.of(context)
                                .translate("scr005.introPart2"),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RoundLoginButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.SCR001_SCREEN);
                      },
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: 2,
        ),
      );
    });
  }
}
