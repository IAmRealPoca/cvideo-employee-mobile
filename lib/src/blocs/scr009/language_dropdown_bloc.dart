import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/blocs/scr009/scr009_bloc_barrel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SCR009LangDropdownBloc
    extends Bloc<SCR009LangDropdownEvent, SCR009LangDropdownState> {
  SCR009LangDropdownBloc();

  @override
  SCR009LangDropdownState get initialState =>
      SCR009LangDropdownState(lang: 'vi');

  @override
  Stream<SCR009LangDropdownState> mapEventToState(
      SCR009LangDropdownEvent event) async* {
    /// When user first navigate to settings screen
    if (event is SCR009LangDropdownEventStart) {
      var prefs = await SharedPreferences.getInstance();

      String lang;

      /// If [LANGUAGE_CODE] is null
      if (prefs.getString(AppConstants.LANGUAGE_CODE) == null) {
        lang = 'vi';
        yield SCR009LangDropdownState(lang: lang);
        return;
      }

      /// Get [LANGUAGE_CODE] from [SharedPreferences]
      lang = prefs.getString(AppConstants.LANGUAGE_CODE);
      yield SCR009LangDropdownState(lang: lang);
    }

    /// When user change language dropdown
    else if (event is SCR009LangDropdownEventChange) {
      yield SCR009LangDropdownState(lang: event.lang);
    }
  }
}
