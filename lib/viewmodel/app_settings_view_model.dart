import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsViewModel extends ChangeNotifier {
  SharedPreferences prefs;

  AppSettingsViewModel(this.prefs);

  String? getLanguageCode() {
    return prefs.getString('languageCode');
  }

  void saveLanguageCode(String languageCode) {
    prefs.setString('languageCode', languageCode);
  }
}