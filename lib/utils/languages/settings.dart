import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LanguageSettings {
  final Locale locale;

  LanguageSettings(this.locale);

  static LanguageSettings? of(BuildContext context) {
    return Localizations.of<LanguageSettings>(context, LanguageSettings);
  }

  late Map<String, String> _localisedValues;

  Future load() async {
    String jsonStringValues =
    await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> mapJson = json.decode(jsonStringValues);

    _localisedValues = mapJson.map((key, value) => MapEntry(key, value));
  }

  String? getTranslatedValue(String key) {
    return _localisedValues[key];
  }

  static const LocalizationsDelegate<LanguageSettings> delegate =
  _DemoLocalisationDelegate();
}

class _DemoLocalisationDelegate
    extends LocalizationsDelegate<LanguageSettings> {
  const _DemoLocalisationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['fr', 'es', 'en', 'sw', 'am','hr','ro'].contains(locale.languageCode);
  }

  @override
  Future<LanguageSettings> load(Locale locale) async {
    LanguageSettings localisation = LanguageSettings(locale);
    await localisation.load();
    return localisation;
  }

  @override
  bool shouldReload(_DemoLocalisationDelegate old) => false;
}
