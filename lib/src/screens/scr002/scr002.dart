/*
 * File: scr002.dart
 * Project: CVideo
 * File Created: Friday, 5th June 2020 10:04:06 am
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Friday, 5th June 2020 9:47:35 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class SCR002 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SCR002State();
  }
}

class SCR002State extends State<SCR002> {
  AppLanguage _appLanguage;
  @override
  void initState() {
    super.initState();
    _appLanguage = AppLanguage();
  }

  @override
  Widget build(BuildContext context) {
    /// Set screen rotation to only vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) => _appLanguage,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RecruitmentBloc>(create: (context) {
            return RecruitmentBloc(postRepository: PostRepository());
          }),
          BlocProvider<EmployeeBloc>(create: (context) {
            return EmployeeBloc(employeeRepository: EmployeeRepository())
              ..add(EmployeeFetched());
          }),
        ],
        child: Scaffold(
          body: Consumer<AppLanguage>(builder: (context, value, child) {
            String lang = AppLocalizations.of(context).locale.languageCode;

            BlocProvider.of<RecruitmentBloc>(context)
              ..add(RecruitmentFetched(lang: lang));
            return Home();
          }),
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: 0,
          ),
        ),
      ),
    );
  }
}
