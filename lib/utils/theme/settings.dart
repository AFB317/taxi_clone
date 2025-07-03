import 'package:flutter/material.dart';

class ThemeSettings {
  static Color lightBG = const Color(0xFFE7E7E7);
  static Color lightPrimary = const Color(0xFF947206);
  static Color lightSecondary = const Color(0xFF00001E);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBG,
    primaryColor: lightPrimary,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: lightBG,
      foregroundColor: lightSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightSecondary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightSecondary,
        side: BorderSide(
          color: lightSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: lightBG, backgroundColor: lightSecondary),
    colorScheme:
    ColorScheme.light(primary: lightPrimary, secondary: lightSecondary)
        .copyWith(surface: lightBG), dialogTheme: DialogThemeData(backgroundColor: lightBG),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
