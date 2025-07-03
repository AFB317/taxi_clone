import 'package:duma_taxi/utils/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager() {
    checkTheme();
  }

  ThemeData theme = ThemeSettings.lightTheme;
  Key key = UniqueKey();

  void setTheme(value, c) async {
    theme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', c);
    notifyListeners();
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r = prefs.getString('theme') ?? 'light';

    if (r == 'light') {
      t = ThemeSettings.lightTheme;
      setTheme(ThemeSettings.lightTheme, 'light');
    } else {
      t = ThemeSettings.darkTheme;
      setTheme(ThemeSettings.darkTheme, 'dark');
    }

    return t;
  }
}
