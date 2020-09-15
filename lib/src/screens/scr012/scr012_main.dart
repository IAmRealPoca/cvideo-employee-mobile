/*
 * File: scr012_main.dart
 * Project: CVideo
 * File Created: Monday, 13th July 2020 2:49:36 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 2:49:40 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr012/src012.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SCR012Main extends StatelessWidget {
  final String url;
  final String title;

  const SCR012Main({Key key, this.url, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkColor,
                fontSize: 15),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            RecruitmentListBloc(postRepository: PostRepository())
              ..add(RecruitmentListFetched(url)),
        child: SCR012(
          title: title,
          url: url,
        ),
      ),
    );
  }
}
