/*
 * File: scr001_splash_screen.dart
 * Project: CVideo
 * File Created: Saturday, 13th June 2020 12:24 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 3:40 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "assets/screens/scr001/login_bg.svg",
            fit: BoxFit.fill
          ),
        ],
      ),
    );
  }
}