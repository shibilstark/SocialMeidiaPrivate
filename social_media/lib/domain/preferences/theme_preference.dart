import 'package:shared_preferences/shared_preferences.dart';

const _ThemeSaveKey = "IsDark";

setThemeStatus(bool value) async {
  final _sharedPrefs = await SharedPreferences.getInstance();
  await _sharedPrefs.setBool(_ThemeSaveKey, value);
}

Future<bool> getThemeStatus() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final isDarkOn = sharedPreferences.getBool(_ThemeSaveKey);

  if (isDarkOn == null || isDarkOn == false) {
    return false;
  } else {
    return true;
  }
}
