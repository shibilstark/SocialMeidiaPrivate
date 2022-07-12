import 'package:shared_preferences/shared_preferences.dart';

const LOGIN_PREF_KEY = "IS_LOGGED";

Future<bool> checkLoginStatus() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  final onceChecked = sharedPreferences.getBool(LOGIN_PREF_KEY);
  if (onceChecked == null || onceChecked == false) {
    return false;
  } else {
    return true;
  }
}

setStatusAsLoggedIn() async {
  final _sharedPrefs = await SharedPreferences.getInstance();
  await _sharedPrefs.setBool(LOGIN_PREF_KEY, true);
}

setStatusAsLoggedOut() async {
  final _sharedPrefs = await SharedPreferences.getInstance();
  await _sharedPrefs.setBool(LOGIN_PREF_KEY, false);
}
