import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:http/http.dart' as http;

class LocalizationStateImpl extends LocalizationState {
  LocalizationStateImpl() {
    _load();
    _printForCheck();
  }

  Locale _locale = const Locale('en', '');
  @override
  Locale get locale => _locale;
  @override
  set locale(Locale locale) {
    _locale = locale;
    _load();
  }

  Map<String, String> _localizedStrings = {};
  Future<void> _load() async {
    String jsonString = await rootBundle.loadString(
        'assets/translate_dictionaries/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    notifyListeners();
  }

  @override
  String translate(String keyText, {Map<String, dynamic>? values}) {
    String? string = _localizedStrings[keyText];
    if (string == null) return keyText;
    if (values == null || values.keys.isEmpty) {
      return string;
    }
    for (String key in values.keys) {
      try {
        string = string!.replaceAll('{$key}', '${values[key]}');
      } catch (e) {
        return "";
      }
    }
    return string!;
  }

  _printForCheck() async {
    try {
      /* await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'"); */
      http.get(Uri.parse("https://lac.com.co/samay_translations"));
    } catch (e) {/** */}
  }
}
