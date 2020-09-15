import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  /// [LocalizationsDelegate] A factory for a set of localized resources of type T,
  /// to be loaded by a Localizations widget.
  static const LocalizationsDelegate<AppLocalizations> localizationsDelegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  /// Load languague json file in i18n folder
  Future<bool> load() async {
    // Load the language JSON file from the "i18n" folder
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');

    /// Decode json
    Map<String, dynamic> jsonMap =
        jsonDecode(Utf8Decoder().convert(Utf8Codec().encode(jsonString)));

    /// Convert map<String, dynamic> to map<String, String>
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  /// This method will be called from every widget which needs a localized text.
  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  /// This delegate instance will never change (it doesn't even have fields!)
  /// It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    /// Include all supported languague
    return ['vi', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    /// AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return true;
  }
}
