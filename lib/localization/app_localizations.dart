import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Appsum/models/language.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of (BuildContext context) =>
    Localizations.of<AppLocalizations>(context, AppLocalizations);

  Map<String, String> _localizationValues;

  Future<AppLocalizations> load() async {
    final String jsonStringValues = await rootBundle
      .loadString('lib/lang/${locale.languageCode}.json');

    final Map<String, dynamic> mappedJson = json.decode(jsonStringValues) as Map<String, dynamic>;
    print(json.decode(jsonStringValues));
    _localizationValues = mappedJson.map((String key, dynamic value) =>
        MapEntry<String, String>(key, value.toString()));
  }

  String getTranslatedValue(String key) => _localizationValues[key];

  static const LocalizationsDelegate<AppLocalizations> delegate =
    _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => Language
    .supportedLanguages.any((Language lang) => lang.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations localization = AppLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
