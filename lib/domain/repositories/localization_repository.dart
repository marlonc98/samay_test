import 'package:flutter/material.dart';

abstract class LocalizationRepository {
  Future<Locale> getLanguage();
}
