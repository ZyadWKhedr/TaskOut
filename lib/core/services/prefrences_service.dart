import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String onboardingCompleteKey = 'onboardingComplete';

  Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(onboardingCompleteKey) ?? false);
  }

  Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompleteKey, true);
  }
}