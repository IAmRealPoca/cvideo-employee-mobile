/*
 * File: rounded_login_button.dart
 * Project: CVideo
 * File Created: Thursday, 4th June 2020 1:19 pm
 * Author: luonglvse130702 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Thursday, 4th June 2020 3:20 pm
 * Modified By: luonglvse130702 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// This button show [text] in the center button,
/// draw icon on the left button with [iconPath] refers to resource,
/// and the [press] that handles the button is clicked.
class RoundedLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final Function press;

  const RoundedLoginButton({
    Key key,
    @required this.text,
    @required this.press,
    @required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Get the [size] metrics of the screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: size.width * 0.8,
      /// Define the material button
      child: MaterialButton(
        /// Set the [height] of the button
        height: 55,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 25,
        ),
        color: AppColors.secondaryColor,
        splashColor: AppColors.secondaryDarkColor,
        shape: StadiumBorder(),
        onPressed: press,
        child: Stack(
          children: <Widget>[
            /// Define the icon of the left of the button
            Positioned(
              left: 0,
              child: Container(
                /// Set the [width] of the icon
                width: 20,

                /// Set the [height] of the icon
                height: 20,
                child: SvgPicture.asset(
                  iconPath,
                  color: AppColors.loginTextColor,
                ),
              ),
            ),
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Define the text in the middle of the button
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.loginTextColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
