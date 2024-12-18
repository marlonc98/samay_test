import 'package:flutter/material.dart';

abstract class LocalizationState with ChangeNotifier {
  abstract Locale locale;
  String translate(String keyText, {Map<String, dynamic>? values});
}
