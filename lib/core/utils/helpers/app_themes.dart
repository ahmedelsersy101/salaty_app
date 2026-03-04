// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// final ThemeData lightPrayerTheme = ThemeData.light(
//   useMaterial3: false,
// ).copyWith(
//   colorScheme: const ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xff001A23),
//     onPrimary: Color(0xff001A23),
//     secondary: Color(0xffeFF4FE),
//     onSecondary: Color(0xff31493C),
//     error: Color(0xffB3EFB2),
//     onError: Color(0xffB3EFB2),
//     surface: Color(0xff7A9E7E),
//     onSurface: Color(0xffB3EFB2),
//     inversePrimary: Color(0xff000000),
//     inverseSurface: Color(0xffCD9974),
//     primaryContainer: Color(0xffE8F1F2),
//     onPrimaryContainer: Color(0xfff3efdf),
//     onInverseSurface: Color(0xff000000),
//     surfaceContainer: Color(0xfffaf7f3),
//     secondaryContainer: Color(0xffFFFFFF),
//   ),
//   primaryColor: const Color(0xff001A23),
//   primaryColorLight: const Color(0xff7A9E7E),
//   primaryColorDark: const Color(0xff001A23),
//   dividerColor: const Color(0xff31493C),
//   highlightColor: const Color(0xff7A9E7E).withValues(alpha: 0.4),
//   scaffoldBackgroundColor: const Color(0xff001A23),
//   canvasColor: const Color(0xffEFF4FE),
//   hoverColor: const Color(0xffEFF4FE).withValues(alpha: 0.3),
//   disabledColor: const Color(0Xff000000),
//   hintColor: const Color(0xff001A23),
//   focusColor: const Color(0xffB3EFB2),
//   secondaryHeaderColor: const Color(0xff7A9E7E),
//   cardColor: const Color(0xff001A23),
//   dividerTheme: const DividerThemeData(
//     color: Color(0xff31493C),
//   ),
//   textSelectionTheme: TextSelectionThemeData(
//       selectionColor: const Color(0xffB3EFB2).withValues(alpha: 0.3),
//       selectionHandleColor: const Color(0xffB3EFB2)),
//   cupertinoOverrideTheme: const CupertinoThemeData(
//     primaryColor: Color(0xff7A9E7E),
//   ),
//   timePickerTheme: TimePickerThemeData(
//     backgroundColor: const Color(0xff31493C),
//     dialBackgroundColor: const Color(0xffEFF4FE),
//     dialHandColor: const Color(0xff31493C),
//     dialTextColor: const Color(0xff000000).withValues(alpha: .6),
//     entryModeIconColor: const Color(0xff000000).withValues(alpha: .6),
//     hourMinuteTextColor: const Color(0xff000000).withValues(alpha: .6),
//     dayPeriodTextColor: const Color(0xff000000).withValues(alpha: .6),
//     cancelButtonStyle: ButtonStyle(
//       backgroundColor: WidgetStateProperty.all(
//           const Color(0xff000000).withValues(alpha: .6)),
//       foregroundColor: WidgetStateProperty.all(const Color(0xffEFF4FE)),
//       shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       textStyle: WidgetStateProperty.all(const TextStyle(
//         fontFamily: 'cairo',
//         fontSize: 16,
//       )),
//     ),
//     confirmButtonStyle: ButtonStyle(
//       backgroundColor: WidgetStateProperty.all(
//           const Color(0xff000000).withValues(alpha: .8)),
//       foregroundColor: WidgetStateProperty.all(const Color(0xffEFF4FE)),
//       shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       textStyle: WidgetStateProperty.all(const TextStyle(
//         fontFamily: 'cairo',
//         fontSize: 16,
//       )),
//     ),
//   ),
//   textTheme: const TextTheme(
//     titleMedium: TextStyle(
//       fontWeight: FontWeight.bold,
//       fontFamily: 'cairo',
//       fontSize: 12,
//       color: Color(0xff001A23),
//     ),
//   ),
// );

// final ThemeData darkTheme = ThemeData.dark(
//   useMaterial3: false,
// ).copyWith(
//   colorScheme: const ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xff001A23),
//     onPrimary: Color(0xff000000),
//     secondary: Color(0xffeFF4FE),
//     onSecondary: Color(0xff373737),
//     error: Color(0xff001A23),
//     onError: Color(0xff001A23),
//     surface: Color(0xff7A9E7E),
//     onSurface: Color(0xff001A23),
//     inversePrimary: Color(0xffeFF4FE),
//     inverseSurface: Color(0xffCD9974),
//     primaryContainer: Color(0xff001A23),
//     onPrimaryContainer: Color(0xff1E1E1E),
//     onInverseSurface: Color(0xff000000),
//     surfaceContainer: Color(0xff1E1E1E),
//     secondaryContainer: Color(0xff1E1E1E),
//   ),
//   primaryColor: const Color(0xff1E1E1E),
//   primaryColorLight: const Color(0xff373737),
//   primaryColorDark: const Color(0xff010101),
//   dividerColor: const Color(0xff001A23),
//   highlightColor: const Color(0xff7A9E7E).withValues(alpha: 0.2),
//   scaffoldBackgroundColor: const Color(0xff000000),
//   canvasColor: const Color(0xffF6F6EE),
//   hoverColor: const Color(0xffF6F6EE).withValues(alpha: 0.3),
//   disabledColor: const Color(0xff000000),
//   hintColor: const Color(0xffeFF4FE),
//   focusColor: const Color(0xff001A23),
//   secondaryHeaderColor: const Color(0xff001A23),
//   cardColor: const Color(0xffF6F6EE),
//   textSelectionTheme: TextSelectionThemeData(
//       selectionColor: const Color(0xff001A23).withValues(alpha: 0.3),
//       selectionHandleColor: const Color(0xff001A23)),
//   cupertinoOverrideTheme: const CupertinoThemeData(
//     primaryColor: Color(0xff001A23),
//   ),
//   timePickerTheme: TimePickerThemeData(
//     backgroundColor: const Color(0xff7A9E7E),
//     dialBackgroundColor: const Color(0xff1E1E1E),
//     dialHandColor: const Color(0xff7A9E7E),
//     dialTextColor: const Color(0xffF6F6EE).withValues(alpha: .6),
//     entryModeIconColor: const Color(0xffF6F6EE).withValues(alpha: .6),
//     hourMinuteTextColor: const Color(0xffF6F6EE).withValues(alpha: .6),
//     dayPeriodTextColor: const Color(0xffF6F6EE).withValues(alpha: .6),
//     dayPeriodColor: const Color(0xff1E1E1E),
//     cancelButtonStyle: ButtonStyle(
//       backgroundColor: WidgetStateProperty.all(
//           const Color(0xffF6F6EE).withValues(alpha: .6)),
//       foregroundColor: WidgetStateProperty.all(const Color(0xff1E1E1E)),
//       shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       textStyle: WidgetStateProperty.all(const TextStyle(
//         fontFamily: 'cairo',
//         fontSize: 16,
//       )),
//     ),
//     confirmButtonStyle: ButtonStyle(
//       backgroundColor: WidgetStateProperty.all(
//           const Color(0xffF6F6EE).withValues(alpha: .8)),
//       foregroundColor: WidgetStateProperty.all(const Color(0xff1E1E1E)),
//       shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       textStyle: WidgetStateProperty.all(const TextStyle(
//         fontFamily: 'cairo',
//         fontSize: 16,
//       )),
//     ),
//   ),
//   textTheme: const TextTheme(
//     titleMedium: TextStyle(
//       fontWeight: FontWeight.bold,
//       fontFamily: 'cairo',
//       fontSize: 12,
//       color: Color(0xff001A23),
//     ),
//   ),
// );
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
//
//  APP THEME  —  Celestial Edition
//
//  Light:  Warm Pearl  · Ivory backgrounds  · Deep midnight text  · Gold accent
//  Dark:   Deep Space  · Midnight navy bg   · Soft pearl text     · Gold accent
//
//  Accent palette (matches PrayerNowWidget):
//    Fajr     → #9B8FFF  (soft violet)
//    Sunrise  → #FFB347  (warm amber)
//    Dhuhr    → #48C6FF  (sky blue)
//    Asr      → #FFD060  (gold)
//    Maghrib  → #FF70A0  (rose)
//    Isha     → #7EB8FF  (cool blue)
//
// ═══════════════════════════════════════════════════════════════════════════════

// ─── Shared raw colours ───────────────────────────────────────────────────────

class _C {
  // Neutrals
  static const midnight = Color(0xFF080C14); // True dark background
  static const deepNavy = Color(0xFF0D1520); // Cards in dark mode
  static const navy = Color(0xFF152032); // Borders/containers dark
  static const steel = Color(0xFF253347); // Subtle surfaces dark

  static const pearl = Color(0xFFF7F3EC); // Main light background
  static const ivory = Color(0xFFFCF9F4); // Card light bg
  static const smoke = Color(0xFFEAE4D8); // Dividers/borders light
  static const ash = Color(0xFFB8B0A4); // Muted text light

  // Brand
  static const gold = Color(0xFFD4A84B); // Primary accent (both)
  static const goldLight = Color(0xFFEAC96A); // Hover/highlight light
  static const goldDeep = Color(0xFFA07830); // Pressed state

  static const ink = Color(0xFF0F1923); // Primary text light
  static const chalk = Color(0xFFF0EBE1); // Primary text dark

  // Semantic
  static const error = Color(0xFFE05A5A);
  static const success = Color(0xFF5EAA6A);
}

// ─── Light Theme ──────────────────────────────────────────────────────────────

final ThemeData lightPrayerTheme = ThemeData.light(
  useMaterial3: false,
).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    // Primary — deep ink, used for nav bar, headers
    primary: _C.ink,
    onPrimary: _C.pearl,

    // Secondary — ivory card surfaces
    secondary: _C.ivory,
    onSecondary: _C.ink,

    // Error slot re-used for subtle tint
    error: _C.smoke,
    onError: _C.ash,

    // Surface — timeline dots, progress bars, bordered elements
    surface: _C.gold,
    onSurface: _C.ink,

    // Text colours
    inversePrimary: _C.ink, // ← main text in light
    inverseSurface: _C.gold, // ← accent gold

    // Containers
    primaryContainer: _C.ivory, // bottom-sheets
    onPrimaryContainer: _C.smoke,

    onInverseSurface: _C.ink,
    surfaceContainer: _C.pearl, // scaffold bg tint
    secondaryContainer: _C.ivory,
  ),

  primaryColor: _C.ink,
  primaryColorLight: _C.gold,
  primaryColorDark: _C.midnight,
  dividerColor: _C.smoke,
  highlightColor: _C.goldLight.withValues(alpha: 0.30),

  scaffoldBackgroundColor: _C.pearl,
  canvasColor: _C.chalk, // icon fill on dark surfaces
  hoverColor: _C.goldLight.withValues(alpha: 0.15),
  disabledColor: _C.ash,
  hintColor: _C.ash,
  focusColor: _C.gold,
  secondaryHeaderColor: _C.gold,
  cardColor: _C.ivory,

  dividerTheme: const DividerThemeData(color: _C.smoke, thickness: 1),

  textSelectionTheme: TextSelectionThemeData(
    selectionColor: _C.gold.withValues(alpha: 0.28),
    selectionHandleColor: _C.gold,
  ),

  cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _C.gold),

  timePickerTheme: TimePickerThemeData(
    backgroundColor: _C.ink,
    dialBackgroundColor: _C.smoke,
    dialHandColor: _C.gold,
    dialTextColor: _C.ink.withValues(alpha: .75),
    entryModeIconColor: _C.chalk.withValues(alpha: .6),
    hourMinuteTextColor: _C.chalk.withValues(alpha: .8),
    dayPeriodTextColor: _C.chalk.withValues(alpha: .8),
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.steel),
      foregroundColor: WidgetStateProperty.all(_C.chalk),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.gold),
      foregroundColor: WidgetStateProperty.all(_C.ink),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
  ),

  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
      fontSize: 12,
      color: _C.ink,
    ),
  ),
);

// ─── Dark Theme ───────────────────────────────────────────────────────────────

final ThemeData darkTheme = ThemeData.dark(
  useMaterial3: false,
).copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,

    // Primary — deep space bg
    primary: _C.deepNavy,
    onPrimary: _C.midnight,

    // Secondary — chalk text
    secondary: _C.chalk,
    onSecondary: _C.steel,

    // Error slot
    error: _C.deepNavy,
    onError: _C.midnight,

    // Surface — gold accent for timeline / borders
    surface: _C.gold,
    onSurface: _C.midnight,

    // Text colours
    inversePrimary: _C.chalk, // ← main text in dark
    inverseSurface: _C.gold, // ← accent gold

    // Containers
    primaryContainer: _C.deepNavy, // bottom-sheets
    onPrimaryContainer: _C.navy,

    onInverseSurface: _C.midnight,
    surfaceContainer: _C.navy, // subtle surface tint
    secondaryContainer: _C.steel,
  ),

  primaryColor: _C.steel,
  primaryColorLight: _C.navy,
  primaryColorDark: _C.midnight,
  dividerColor: _C.navy,
  highlightColor: _C.gold.withValues(alpha: 0.18),

  scaffoldBackgroundColor: _C.midnight,
  canvasColor: _C.chalk, // icon fill on dark surfaces
  hoverColor: _C.chalk.withValues(alpha: 0.10),
  disabledColor: _C.midnight,
  hintColor: _C.chalk,
  focusColor: _C.deepNavy,
  secondaryHeaderColor: _C.deepNavy,
  cardColor: _C.chalk,

  dividerTheme: const DividerThemeData(color: _C.navy, thickness: 1),

  textSelectionTheme: TextSelectionThemeData(
    selectionColor: _C.gold.withValues(alpha: 0.25),
    selectionHandleColor: _C.gold,
  ),

  cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _C.gold),

  timePickerTheme: TimePickerThemeData(
    backgroundColor: _C.navy,
    dialBackgroundColor: _C.steel,
    dialHandColor: _C.gold,
    dialTextColor: _C.chalk.withValues(alpha: .75),
    entryModeIconColor: _C.chalk.withValues(alpha: .6),
    hourMinuteTextColor: _C.chalk.withValues(alpha: .8),
    dayPeriodTextColor: _C.chalk.withValues(alpha: .8),
    dayPeriodColor: _C.steel,
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.chalk.withValues(alpha: .12)),
      foregroundColor: WidgetStateProperty.all(_C.chalk),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_C.gold),
      foregroundColor: WidgetStateProperty.all(_C.ink),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: 'cairo', fontSize: 16)),
    ),
  ),

  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
      fontSize: 12,
      color: _C.deepNavy,
    ),
  ),
);
