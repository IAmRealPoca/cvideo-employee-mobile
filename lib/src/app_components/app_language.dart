import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_components.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('vi');
  Locale get appLocale => _appLocale;


  Future<void> fetchLocale() async {
    /// Get [SharedPreferences] instance
    var prefs = await SharedPreferences.getInstance();

    /// If [LANGUAGE_CODE] is null
    if (prefs.getString(AppConstants.LANGUAGE_CODE) == null) {
      _appLocale = Locale('vi');
      return null;
    }

    /// Get [LANGUAGE_CODE] from [SharedPreferences]
    _appLocale = Locale(prefs.getString(AppConstants.LANGUAGE_CODE));
  }

  /// Handle when user change language
  void changeLanguague(Locale type) async {
    /// Get [SharedPreferences] instance
    var prefs = await SharedPreferences.getInstance();

    if (_appLocale == type) return;

    if (type == Locale('vi')) {
      _appLocale = Locale('vi');
      await prefs.setString(AppConstants.LANGUAGE_CODE, 'vi');
    } else {
      _appLocale = Locale('en');
      await prefs.setString(AppConstants.LANGUAGE_CODE, 'en');
    }

    /// Nofify the app when languague is change
    notifyListeners();
  }
}