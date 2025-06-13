import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale("en");

  Locale get appLocale => _appLocale;

  Future<void> loadLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String? storedLanguageCode = prefs.getString("languageCode");

    if (storedLanguageCode != null) {
      _appLocale = Locale.fromSubtags(languageCode: storedLanguageCode);
    } else {
      final List<Locale> systemLocales =
          WidgetsBinding.instance.platformDispatcher.locales;
      if (systemLocales.isNotEmpty) {
        _appLocale = systemLocales.first;
      }
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', locale.languageCode);

    _appLocale = locale;
    notifyListeners();
  }
}
