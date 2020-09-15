/*
 * File: constants.dart
 * Project: CVideo
 * File Created: Thursday, 4th June 2020 10:59 am
 * Author: luonglvse130702 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Thursday, 4th June 2020 2:55 pm
 * Modified By: luonglvse130702 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
class AppConstants {
  static const String SECURE_API_TOKEN = "SECURE_API_TOKEN";
  static const LANGUAGE_CODE = "language_code";
}

class AppRoutes {
  static const SCR001_SCREEN = '/SCR001';
  static const SCR002_SCREEN = '/SCR002_SCREEN';
  static const SCR008_SCREEN = '/SCR008';
  static const SCR003_SCREEN = '/SCR003';
  static const SCR006_SCREEN = '/SCR006';
  static const SCR010_SCREEN = '/SCR010_SCREEN';
  static const SCR011_SCREEN = '/SCR011_SCREEN';
  static const String SCR005_SCREEN = '/SCR005_SCREEN';
  static const String UPDATE_EMPLOYEE_SCREEN = '/UPDATE_EMPLOYEE_SCREEN';
  static const String SCR004_SCREEN = '/SCR004_SCREEN';
  static const String SCR013_SCREEN = '/SCR013_SCREEN';
  static const String SCR014_SCREEN = '/SCR014_SCREEN';
  static const String SCR009_SCREEN = '/SCR009_SCREEN';
  static const String SCR012_MAIN_SCREEN = '/SCR012_MAIN_SCREEN';
}

class AppSupportLanguage {
  static const Map<String, String> languageSupports = {
    "vi": "Tiếng Việt",
    "en": "English"
  };
}

class SCR001Constants {
  static const FCM_ERR = "scr001.errMsgFCM";
  static const API_TOKEN_ERR = "scr001.errMsgApiToken";
  static const LOGIN_FAIL_ERR = "scr001.errMsgLoginFail";
}
