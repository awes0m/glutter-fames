import 'package:flutter/material.dart';

import 'shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  /// _isDark: boolean variable gives the status of the theme
  /// _preferences: is an instance variable for ThemePreferences class
  /// ThemeModel() constructor is to initialize the member variables and load the theme status from the shared preference by getPreference() method.
  /// getPreference() method loads the theme status from shared preference and sets it to _isDark
  /// notifyListerners() method to rebuild the UI based on the new value of _isDark
  ThemeModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}

ThemeData dark = ThemeData.from(
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
    headline1: TextStyle(color: Colors.white),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.white),
    subtitle1: TextStyle(color: Colors.white),
    subtitle2: TextStyle(color: Colors.white),
    caption: TextStyle(color: Colors.white),
    button: TextStyle(color: Colors.white),
    overline: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    shadow: Colors.black,
    primary: Colors.indigo[400]!,
    onPrimary: Colors.indigo[900]!,
    secondary: Colors.indigo[400]!,
    onSecondary: Colors.indigo[900]!,
    surface: Colors.indigo[400]!,
    onSurface: Colors.indigo[900]!,
    background: Colors.indigo[400]!,
    onBackground: Colors.indigo[900]!,
    error: Colors.orange,
    onError: Colors.orangeAccent,
    brightness: Brightness.dark,
  ),
);

ThemeData light = ThemeData.from(
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.deepPurple[900]!),
    bodyText2: TextStyle(color: Colors.deepPurple[900]!),
    headline1: TextStyle(color: Colors.deepPurple[900]!),
    headline2: TextStyle(color: Colors.deepPurple[900]!),
    headline3: TextStyle(color: Colors.deepPurple[900]!),
    headline4: TextStyle(color: Colors.deepPurple[900]!),
    headline5: TextStyle(color: Colors.deepPurple[900]!),
    headline6: TextStyle(color: Colors.deepPurple[900]!),
    subtitle1: TextStyle(color: Colors.deepPurple[900]!),
    subtitle2: TextStyle(color: Colors.deepPurple[900]!),
    caption: TextStyle(color: Colors.deepPurple[900]!),
    button: TextStyle(color: Colors.deepPurple[900]!),
    overline: TextStyle(color: Colors.deepPurple[900]!),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.cyan[100]!,
    onPrimary: Colors.cyan[900]!,
    secondary: Colors.cyan,
    onSecondary: Colors.cyan[900]!,
    surface: Colors.cyan,
    onSurface: Colors.cyan[900]!,
    background: Colors.cyan[100]!,
    onBackground: Colors.cyan[900]!,
    error: Colors.red,
    onError: Colors.redAccent,
    brightness: Brightness.light,
  ),
);
