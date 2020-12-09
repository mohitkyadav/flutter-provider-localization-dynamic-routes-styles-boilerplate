import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Appsum/app_bootstrap.dart';
import 'package:Appsum/models/language.dart';

class HomeAppbarActions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      // ignore: always_specify_types
      child: DropdownButton(
        underline: const SizedBox(),
        onChanged: (Language language) {
          _changeLanguage(context, language);
        },
        iconEnabledColor: Theme.of(context).accentColor,
        icon: const Icon(Icons.language),
        // ignore: always_specify_types
        items: Language.supportedLanguages.map((Language lan) => DropdownMenuItem(
            value: lan,
            child: Row(
              children: <Widget> [
                Text(lan.flag),
                const SizedBox(width: 10,),
                Text(lan.name),
              ],
            ))
          ).toList(),
      ),
    );
  }

  void _changeLanguage(BuildContext context, Language language) {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      prefs.setString('selectedLocale',
          '${language.languageCode}-${language.countryCode}');
      AppBootstrap.setLocale(context,
          Locale(language.languageCode, language.countryCode));
    });
  }
}
