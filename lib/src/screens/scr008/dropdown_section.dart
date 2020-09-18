/*
 * File: dropdown_section.dart
 * Project: CVideo
 * File Created: Friday, 10th July 2020 1:53 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:07 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropdownSection extends StatelessWidget {
  static const _ICON_WIDTH = 24.0;
  static const _TITLE_FONT_SIZE = 16.0;
  static const _TITLE_FONT_WEIGHT = FontWeight.w600;
  static const _DROPDOWN_BORDER_WIDTH = 1.5;
  static const _DROPDOWN_BORDER_RADIUS = 10.0;
  static const _DROPDOWN_PADDING_HORIZONTAL = 12.0;
  static const _DROPDOWN_TRAILING_ICON =
      "assets/screens/common_icon/ic_dropdown.svg";
  static const _DROPDOWN_TRAILING_ICON_WIDTH = 20.0;
  static const _DROPDOWN_ELEVATION = 4;

  const DropdownSection({
    Key key,
    @required int selectedValue,
    @required List<dynamic> listChild,
    @required String dropdownTitle,
    @required String iconPath,
    @required Function press,
  })  : this._selectedValue = selectedValue,
        this._listChild = listChild,
        this._dropdownTitle = dropdownTitle,
        this._iconPath = iconPath,
        this._press = press,
        super(key: key);

  final String _dropdownTitle;
  final String _iconPath;
  final int _selectedValue;
  final List<dynamic> _listChild;
  final Function _press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width * 0.4,
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  /// Set dropdown icon path
                  _iconPath,
                  width: _ICON_WIDTH,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  /// Set dropdown title
                  _dropdownTitle,
                  style: TextStyle(
                      fontSize: _TITLE_FONT_SIZE,
                      fontWeight: _TITLE_FONT_WEIGHT),
                ),
              ],
            ),
          ),
          // Question set dropdown section
          Expanded(
            child: Container(
              /// Style dropdown with border corner
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(

                      /// Set dropdown border width
                      width: _DROPDOWN_BORDER_WIDTH,
                      style: BorderStyle.solid,
                      color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(
                      Radius.circular(_DROPDOWN_BORDER_RADIUS)),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: _DROPDOWN_PADDING_HORIZONTAL),

              /// Build dropdown menu list
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _selectedValue,
                  icon: SvgPicture.asset(
                    /// Set trailing icon path
                    _DROPDOWN_TRAILING_ICON,

                    /// Set trailing icon color
                    color: AppColors.primaryColor,

                    /// Set trailing icon width
                    width: _DROPDOWN_TRAILING_ICON_WIDTH,
                  ),
                  elevation: _DROPDOWN_ELEVATION,
                  items: _listChild.map<DropdownMenuItem<int>>((item) {
                    /// Build dropdown's item
                    return DropdownMenuItem<int>(
                      value: item.id,
                      child: Container(
                        width: size.width * 0.35,
                        child: Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),

                  /// Handle when user selecte an item
                  onChanged: _press,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
