import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  final String isSyncOnCalendar = "isSyncOnCalendar";

  /// ------------------------------------------------------------
  /// Method that saves the sync setting
  /// ------------------------------------------------------------
  Future<bool> setIsSyncOnCalendar(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(isSyncOnCalendar, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user's preferred language
  /// ------------------------------------------------------------
  Future<bool> getIsSyncOnCalendar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isSyncOnCalendar) == null) {
      await setIsSyncOnCalendar(true);
    }
    return prefs.getBool(isSyncOnCalendar);
  }
}
