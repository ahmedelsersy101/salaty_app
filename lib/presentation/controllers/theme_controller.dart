import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/utils/constants/shared_preferences_constants.dart';
import '../../core/utils/helpers/app_themes.dart';

enum AppTheme { light, dark }

class ThemeController extends GetxController {
  static ThemeController get instance =>
      GetInstance().putOrFind(() => ThemeController());

  AppTheme? initialTheme;
  ThemeData? initialThemeData;
  final Rx<AppTheme> _currentTheme = AppTheme.light.obs;
  final box = GetStorage();

  @override
  void onInit() async {
    var theme = await loadThemePreference();
    setTheme(theme);
    super.onInit();
  }

  void checkTheme() {
    switch (initialTheme) {
      case AppTheme.light:
        initialThemeData = lightPrayerTheme;
        break;
      case AppTheme.dark:
        initialThemeData = darkTheme;
        break;
      default:
        initialThemeData = lightPrayerTheme;
    }
  }

  Future<AppTheme> loadThemePreference() async {
    String themeString = box.read(SET_THEME) ?? AppTheme.light.toString();
    return initialTheme = AppTheme.values.firstWhere(
      (e) => e.toString() == themeString,
      orElse: () => AppTheme.light,
    );
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme.value = theme;
    ThemeData newThemeData;
    switch (theme) {
      case AppTheme.light:
        newThemeData = lightPrayerTheme;
        break;
      case AppTheme.dark:
        newThemeData = darkTheme;
        break;
    }

    Get.changeTheme(newThemeData);

    // Save theme preference
    box.write(SET_THEME, theme.toString());
    update();
    Get.forceAppUpdate();
  }

  ThemeData get currentThemeData {
    switch (_currentTheme.value) {
      case AppTheme.light:
        return lightPrayerTheme;
      case AppTheme.dark:
        return darkTheme;
    }
  }

  AppTheme get currentTheme => _currentTheme.value;

  bool get isBlueMode => _currentTheme.value == AppTheme.light;
  bool get isDarkMode => _currentTheme.value == AppTheme.dark;
}
