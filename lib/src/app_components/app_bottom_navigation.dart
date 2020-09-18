/*
 * File: app_bottom_navigation.dart
 * Project: CVideo
 * File Created: Monday, 13th July 2020 9:00:02 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Tuesday, 14th July 2020 9:00:04 am
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */

import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigationBar extends StatefulWidget {
  int _currentIndex;
  AppBottomNavigationBar({
    Key key,
    @required int currentIndex,
  })  : this._currentIndex = currentIndex,
        super(key: key);

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

/// Widget for build custom bottom navigation bar
class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  static const _navigationBarElevation = 0.0;
  static const _titleFontSize = 11.0;

  int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget._currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.secondaryTextColor,
      elevation: _navigationBarElevation,

      /// [currentIndex] indicate which item is actived
      currentIndex: widget._currentIndex,

      /// call [onItemTapped] when user click an item
      onTap: onItemTapped,

      /// Set [BottomNavigationBarType] to fixed type
      type: BottomNavigationBarType.fixed,
      items: [
        /// Build HOME item
        buildBottomNavigationBarItem(
          iconPath: "assets/screens/common_icon/ic_home.svg",
          title: AppLocalizations.of(context).translate("appBar.home"),
          order: 0,
        ),

        /// Build RESUMES Item
        buildBottomNavigationBarItem(
          iconPath: "assets/screens/common_icon/ic_resume.svg",
          title: AppLocalizations.of(context).translate("appBar.resumes"),
          order: 1,
        ),

        /// Build User Item
        buildBottomNavigationBarItem(
          iconPath: "assets/screens/common_icon/ic_user.svg",
          title: AppLocalizations.of(context).translate("appBar.user"),
          order: 2,
        ),

        //// Build Favorite Item
        buildBottomNavigationBarItem(
          iconPath: "assets/screens/common_icon/ic_settings.svg",
          title: AppLocalizations.of(context).translate("appBar.settings"),
          order: 3,
        ),
      ],
    );
  }

  /// Draw a bottom navigation item
  BottomNavigationBarItem buildBottomNavigationBarItem(
      {@required String iconPath,
      @required String title,
      @required int order}) {
    return BottomNavigationBarItem(
      /// When item is inactive state
      icon: BottomNavigationBarItemIcon(
        iconPath: iconPath,
        isActive: false,
      ),

      /// When item is active state
      activeIcon: BottomNavigationBarItemIcon(
        iconPath: iconPath,
        isActive: true,
      ),
      title: Text(
        /// Set item's title
        title,
        style: TextStyle(
            color: order == _currentIndex
                ? AppColors.bottomAppBarItemActiveColor
                : AppColors.bottomAppBarItemInactiveColor,
            fontSize: _titleFontSize,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  /// Handle when bottom app bar item is tapped
  void onItemTapped(int index) {
    if (index != _currentIndex) {
      switch (index) {
        case 0:
          Navigator.of(context).pushNamed(AppRoutes.SCR002_SCREEN);
          break;
        case 1:
          Navigator.of(context).pushNamed(AppRoutes.SCR003_SCREEN);
          break;
        case 2:
          Navigator.of(context).pushNamed(AppRoutes.SCR005_SCREEN);
          break;
        case 3:
          Navigator.of(context).pushNamed(AppRoutes.SCR009_SCREEN);
          break;
        default:
          Navigator.of(context).pushNamed(AppRoutes.SCR013_SCREEN);
      }
    }
  }
}

// Draw a bottom navigation item icon
class BottomNavigationBarItemIcon extends StatelessWidget {
  static const _iconSize = 24.0;
  const BottomNavigationBarItemIcon({
    Key key,
    @required String iconPath,
    @required bool isActive,
  })  : this._iconPath = iconPath,
        this._isActive = isActive,
        super(key: key);

  /// icon's path
  final String _iconPath;

  /// [_isActive] set the icon's color based on item's state
  final bool _isActive;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      /// Set icon path
      _iconPath,

      /// Set width of icon
      width: _iconSize,

      /// Set height of icon
      height: _iconSize,

      /// Set color of icon based on [_isActive] bool
      color: _isActive
          ? AppColors.bottomAppBarItemActiveColor
          : AppColors.bottomAppBarItemInactiveColor,
    );
  }
}
