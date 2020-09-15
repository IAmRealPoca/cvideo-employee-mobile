/*
 * File: scr009.dart
 * Project: CVideo
 * File Created: Monday, 13th July 2020 12:45 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:07 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SCR009 extends StatelessWidget {
  static const _SETTING_TITLE_FONT_SIZE = 26.0;
  static const _SETTING_PADDING_HORIZONTAL = 20.0;
  static const _SETTING_MARGIN_STATUS_BAR = 24.0;
  static const _OPTION_ICON_WIDTH = 20.0;
  static const _OPTION_TITLE_FONT_SIZE = 18.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appLanguage = Provider.of<AppLanguage>(context);
    return BlocProvider<SCR009LangDropdownBloc>(
      create: (context) =>
          SCR009LangDropdownBloc()..add(SCR009LangDropdownEventStart()),
      child: Scaffold(
        bottomNavigationBar: AppBottomNavigationBar(currentIndex: 3),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: <Widget>[
              /// Settings title section
              Container(
                width: size.width,
                height: size.height * 0.16,
                color: AppColors.primaryColor,
                child: Container(
                  margin: EdgeInsets.only(top: _SETTING_MARGIN_STATUS_BAR),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _SETTING_PADDING_HORIZONTAL,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate("scr009.appTitle"),
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: _SETTING_TITLE_FONT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              /// Settings options sections
              /// Language section
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: _SETTING_PADDING_HORIZONTAL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// Language icon and title
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/screens/scr009/ic_language.svg",
                            width: _OPTION_ICON_WIDTH,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            AppLocalizations.of(context)
                                .translate("scr009.langTitle"),
                            style: TextStyle(
                              fontSize: _OPTION_TITLE_FONT_SIZE,
                            ),
                          )
                        ],
                      ),
                    ),

                    /// Language dropdown
                    BlocBuilder<SCR009LangDropdownBloc,
                        SCR009LangDropdownState>(
                      builder: (context, state) {
                        return Container(
                          width: size.width * 0.3,
                          child: DropdownButton(
                            isExpanded: true,
                            value: state.lang,
                            items: AppSupportLanguage.languageSupports
                                .map((key, value) => MapEntry(
                                    key,
                                    DropdownMenuItem(
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: _OPTION_TITLE_FONT_SIZE),
                                      ),
                                      value: key,
                                    )))
                                .values
                                .toList(),
                            onChanged: (value) {
                              /// call [AppLanguage] to change language
                              appLanguage.changeLanguague(Locale(value));

                              /// BlocProvider for [SCR009LangDropdownBloc]
                              BlocProvider.of<SCR009LangDropdownBloc>(context)
                                  .add(SCR009LangDropdownEventChange(
                                      lang: value));
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoutes.SCR002_SCREEN, (route) => false);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),

              /// Logout section
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _SETTING_PADDING_HORIZONTAL,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AuthenticationLoggedOut());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.SCR002_SCREEN, (route) => false);
                        },
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/screens/scr009/ic_logout.svg",
                              width: _OPTION_ICON_WIDTH,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("scr009.logoutTitle"),
                              style:
                                  TextStyle(fontSize: _OPTION_TITLE_FONT_SIZE),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
