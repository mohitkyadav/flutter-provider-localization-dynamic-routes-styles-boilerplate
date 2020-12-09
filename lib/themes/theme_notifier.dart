import 'package:flutter/material.dart';

import 'package:Appsum/models/app_theme.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeNotifier(this._appTheme);

  AppTheme _appTheme;

  AppTheme get getAppTheme => _appTheme;

  // ignore: avoid_void_async
  void setTheme(AppTheme appTheme) async {
    _appTheme = appTheme;

    notifyListeners();
  }
}
