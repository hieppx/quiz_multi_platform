import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeProvider({
    ThemeMode mode = ThemeMode.dark,
  }) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Locale _currentLocale = const Locale('vi');
  Locale get currentLocale => _currentLocale;

  void changeLocale(String locale) async {
    _currentLocale = Locale(locale);
    notifyListeners();
  }
}
