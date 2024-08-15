import 'package:flutter/material.dart';
import 'package:minimalnote/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => themeData == darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = ThemeData();
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
  }
}
