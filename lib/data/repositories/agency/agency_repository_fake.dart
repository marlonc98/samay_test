// ignore_for_file: implementation_imports

import 'dart:math';
import 'dart:ui';
import 'package:either_dart/src/either.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
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
  Future<ThemeData> getThemeFromAgency(AgencyEntity? agency) async {
    if (agency == null) {
      return lightTheme();
    }
    Color color = Color(int.parse('0xFF${agency.hexColor}'));
    ThemeData theme = lightTheme(colorMain: color);
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
    //get random hex color for testing
    String toHex(int value) {
      return value.toRadixString(16).padLeft(2, '0');
    }

    String getRandomHexColor() {
      Random random = Random();
      // Generamos un valor aleatorio para cada componente de color (Rojo, Verde, Azul)
      int r = random.nextInt(256); // Rojo
      int g = random.nextInt(256); // Verde
      int b = random.nextInt(256); // Azul

      // Convertimos cada componente a su valor hexadecimal
      String hexColor = '${toHex(r)}${toHex(g)}${toHex(b)}';
      return hexColor;
    }

    ();
    for (int i = 0; i < totalToReturn; i++) {
      final String randomHex = getRandomHexColor();
      agencies.add(AgencyEntity(
          id: i.toString(),
          name: i.toString() + fakeAgency.name + randomHex,
          logo: fakeAgency.logo,
          hexColor: randomHex,
          aditionalFields: fakeAgency.aditionalFields));
    }
    return Right(agencies);
  }

  @override
  Future<void> selectAgent(String agentId) {
    return Future.delayed(const Duration(seconds: 1));
  }
}
