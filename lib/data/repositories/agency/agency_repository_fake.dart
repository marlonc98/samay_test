import 'dart:ui';
import 'package:either_dart/src/either.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';
import 'package:samay/domain/repositories/agency_respository.dart';
import 'package:samay/presentation/ui/theme/light_theme.dart';

AgencyEntity fakeAgency = AgencyEntity(
  id: '1',
  name: 'Fake Agency',
  hexColor: 'FF0000',
  logo:
      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/agency-logo-design-template-63d79adb61b0737cf1c996c9ce6661e0_screen.jpg?ts=1677711623',
  aditionalFields: [],
);

class AgencyRepositoryFake extends AgencyRepository {
  @override
  Future<ThemeData> getThemeFromAgency(AgencyEntity agency) async {
    Color color = Color(int.parse('0xFF${agency.hexColor}'));
    ThemeData theme = lightTheme.copyWith(
      primaryColor: color,
      colorScheme: lightTheme.colorScheme.copyWith(
        primary: color,
        secondary: color,
      ),
    );
    return theme;
  }

  @override
  Future<Either<ExceptionEntity, AgencyEntity?>> loadSelectedAgent() async {
    await Future.delayed(const Duration(seconds: 1));
    // return Right(fakeAgency);
    return const Right(null);
  }

  @override
  Future<Either<ExceptionEntity, List<AgencyEntity>>> getAllAgents() async {
    await Future.delayed(const Duration(seconds: 1));
    const totalToReturn = 10;
    List<AgencyEntity> agencies = [];
    for (int i = 0; i < totalToReturn; i++) {
      agencies.add(AgencyEntity(
          id: i.toString(),
          name: fakeAgency.name,
          logo: fakeAgency.logo,
          aditionalFields: fakeAgency.aditionalFields));
    }
    return Right(agencies);
  }

  @override
  Future<void> selectAgent(String agentId) {
    return Future.delayed(const Duration(seconds: 1));
  }
}
