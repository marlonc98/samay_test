import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/aditional_field_entity.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/agency_respository.dart';

AgencyEntity fakeAgency = AgencyEntity(
  id: '1',
  name: 'Fake Agency',
  hexColor: 'FF0000',
  logo:
      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/agency-logo-design-template-63d79adb61b0737cf1c996c9ce6661e0_screen.jpg?ts=1677711623',
  aditionalFields: [
    AditionalFieldEntity(
        name: "Certificates",
        type: AditionalFielType.text,
        hint: "ISO ...",
        value: "ISO 121212, ISO 121212"),
    AditionalFieldEntity(
        name: "Built Year",
        type: AditionalFielType.number,
        value: "2021",
        hint: "1999..."),
    AditionalFieldEntity(
        name: 'Taxes Dates',
        type: AditionalFielType.date,
        value: DateTime.now(),
        hint: "205-12-11"),
  ],
);

class AgencyRepositoryFake extends AgencyRepository {
  @override
  Future<Either<ExceptionEntity, AgencyEntity?>> loadSelectedAgent() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(fakeAgency);
    // return const Right(null);
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
          name: fakeAgency.name + randomHex,
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
