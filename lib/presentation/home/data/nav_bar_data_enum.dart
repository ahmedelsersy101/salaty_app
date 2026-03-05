part of '../home.dart';

enum NavBarTab {
  prayer,
  prayerTimes,
  qibla,
  settings;

  String get label {
    switch (this) {
      case NavBarTab.prayer:
        return 'prayer';
      case NavBarTab.qibla:
        return 'qibla';
      case NavBarTab.prayerTimes:
        return 'prayerTimes';
      case NavBarTab.settings:
        return 'settings';
    }
  }

  String get icon {
    switch (this) {
      case NavBarTab.prayer:
        return SvgPath.svgHomeMosque;
      case NavBarTab.qibla:
        return SvgPath.svgHomeKaaba;
      case NavBarTab.prayerTimes:
        return SvgPath.svgHomeTeachingPrayer;
      case NavBarTab.settings:
        return SvgPath.svgHomeSettings;
    }
  }

  // @override
  int get tapIndex {
    return NavBarTab.values.indexOf(this);
  }

  Widget get currentScreen {
    switch (this) {
      case NavBarTab.prayer:
        return PrayerScreen();
      case NavBarTab.qibla:
        return QiblaScreen();
      case NavBarTab.prayerTimes:
        return const PrayerTimesScreen();
      case NavBarTab.settings:
        return const SettingsScreen();
    }
  }
}
