/*
 * File: apply_button.dart
 * Project: CVideo
 * File Created: Sunday, 21st June 2020 7:42:18 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 21st June 2020 7:42:24 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/app_components/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundLoginButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  const RoundLoginButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .06,
      width: size.width * .4,
      child: RawMaterialButton(
          elevation: 2,
          fillColor: AppColors.primaryColor,
          shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                   AppLocalizations.of(context).translate("scr005.loginNow"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          onPressed: onPressed),
    );
  }
}
