import 'package:flutter/material.dart';
import 'package:samay/domain/repositories/localization_repository.dart';

class LocalizationRepositoryFake extends LocalizationRepository {
  @override
  Future<Locale> getLanguage() async {
    return const Locale("es", "ES");
  }
}
