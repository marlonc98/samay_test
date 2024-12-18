import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samay/domain/states/Localization/localization_state.dart';

class LocalizationStateImpl extends LocalizationState {

  LocalizationStateImpl() {
    _load();
  }
  
  Locale _locale = const Locale('es', '');
  @override
  Locale get locale => _locale;
  @override
  set locale(Locale locale) {
    _locale = locale;
    _load();
  }

  Map<String, String> _localizedStrings = {};
  Future<void> _load() async {
    String jsonString = await rootBundle
        .loadString('assets/translate_dictionaries/${locale.languageCode}.json');
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
}
