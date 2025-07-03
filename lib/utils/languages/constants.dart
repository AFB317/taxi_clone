import 'package:duma_taxi/utils/languages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? getTranslated(BuildContext context, String key) {
  return LanguageSettings.of(context)!.getTranslatedValue(key);
}

const String french = 'fr';
const String ikirundi = 'es';
const String english = 'en';
const String swahili = 'sw';
const String amharic = 'am';
const String uganda = 'hr';
const String rwanda = 'ro';

const String languageCode = 'languageCode';

Future<Locale> setLocale(String lc) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCode, lc);
  return _locale(lc);
}

Locale _locale(String languageCode) {
  Locale temp;
  switch (languageCode) {
    case english:
      temp = Locale(languageCode, 'UK');
      break;
    case ikirundi:
      temp = Locale(languageCode, 'ES');
      break;
    case french:
      temp = Locale(languageCode, 'FR');
      break;
    case swahili:
      temp = Locale(languageCode, 'SW');
      break;
    case amharic:
      temp = Locale(languageCode, 'AM');
      break;
    case uganda:
      temp = Locale(languageCode, 'HR');
      break;
    case rwanda:
      temp = Locale(languageCode, 'RO');
      break;
    default:
      temp = const Locale(english, 'UK');
  }
  return temp;
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String lc = prefs.getString(languageCode) ?? english;
  return _locale(lc);
}
