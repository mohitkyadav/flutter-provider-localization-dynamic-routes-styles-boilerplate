import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Appsum/themes/theme_notifier.dart';
import 'package:Appsum/themes/app_themes.dart';

import 'package:Appsum/app_bootstrap.dart';

void main () {
  WidgetsFlutterBinding.ensureInitialized();
  // get selected settings for theme and locale
  SharedPreferences.getInstance().then((SharedPreferences prefs) {
    final bool darkModeOn = prefs.getBool('darkMode') ?? true;
    final String selectedLocaleCode = prefs.getString('selectedLocale');
    Locale selectedLocale;

    if (selectedLocaleCode != null) {
      if (selectedLocaleCode.split('-').length == 2) {
        selectedLocale = Locale(
            selectedLocaleCode.split('-')[0], selectedLocaleCode.split('-')[1]);
      }
    }

    runApp(MyApp(darkModeOn, selectedLocale));
  });
}

class MyApp extends StatelessWidget {
  const MyApp(this._darkModeOn, this._selectedLocale,);

  final bool _darkModeOn;
  final Locale _selectedLocale;

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>
          .value(value: ThemeNotifier(_darkModeOn ? darkTheme : lightTheme))
      ],
      child: AppBootstrap(_selectedLocale),
    );
  }
}
