
import 'package:shared_preferences/shared_preferences.dart';

class SettingPreference{
  final String TEXT_ONLY_MODE = "text_only_mode";

  void setTextOnlyMode(bool isTextOnly) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(TEXT_ONLY_MODE, isTextOnly);
  }

  Future<bool> isTextOnlyMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isTextOnly = prefs.getBool(TEXT_ONLY_MODE);
    return isTextOnly;
  }

}