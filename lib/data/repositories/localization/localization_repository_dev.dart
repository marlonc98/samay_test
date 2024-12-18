import 'package:flutter/material.dart';
import 'package:samay/data/repositories/localization/api/get_language_api_impl.dart';
import 'package:samay/domain/repositories/localization_repository.dart';

class LocalizationRepositoryDev extends LocalizationRepository {
  final String localizationRepositoryKey = 'localization_repository_key';

  @override
  Future<Locale> getLanguage() =>
      getLanguageApiImpl(localizationRepositoryKey);
}