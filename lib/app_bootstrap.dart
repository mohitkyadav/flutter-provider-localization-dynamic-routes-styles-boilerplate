import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:Appsum/routes/custom_router.dart';
import 'package:Appsum/routes/route_names.dart';
import 'package:Appsum/themes/theme_notifier.dart';

import 'localization/app_localizations.dart';
import 'models/language.dart';

class AppBootstrap extends StatefulWidget {
  AppBootstrap(this.selectedLocale, {Key key,}) : super(key: key);

  final Locale selectedLocale;

  @override
  _AppBootstrapState createState() => _AppBootstrapState();

  static void setLocale(BuildContext context, Locale locale) {
    _AppBootstrapState state = context.findAncestorStateOfType<_AppBootstrapState>();
    state.setLocale(locale);
  }
}

class _AppBootstrapState extends State<AppBootstrap> {
  Locale _selectedLocale;

  @override
  void initState() {
    _selectedLocale = widget.selectedLocale;
    super.initState();
  }

  void setLocale(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getAppTheme.themeData,
      onGenerateRoute: CustomRouter.allRoutes,
      initialRoute: homeRoute,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      locale: _selectedLocale,
      supportedLocales: Language.supportedLocales(),
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (_selectedLocale != null) {
          return _selectedLocale;
        }
        // set device locale as selected locale
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode
              && locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }

        return supportedLocales.first;
      },
    );
  }
}
