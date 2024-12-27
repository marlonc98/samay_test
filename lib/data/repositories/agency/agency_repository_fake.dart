import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/aditional_field_entity.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/agency_respository.dart';

AgencyEntity fakeAgency = AgencyEntity(
  id: '2001',
  name: 'Home solutions',
  hexColor: 'efbe46',
  logo: 'assets/temp_images/agency1.png',
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

AgencyEntity fakeAgent2 = AgencyEntity(
    id: "2002",
    name: "Home company",
    hexColor: "668638",
    logo: "assets/temp_images/agency2.png",
    aditionalFields: [
      AditionalFieldEntity(
          name: "Built Year",
          type: AditionalFielType.number,
          value: "2021",
          hint: "1999..."),
    ]);

AgencyEntity fakeAgent3 = AgencyEntity(
  id: "2003",
  name: "House marketing",
  hexColor: "26fc00",
  logo: "assets/temp_images/agency3.png",
  aditionalFields: [
    AditionalFieldEntity(
        name: "Certificates",
        type: AditionalFielType.text,
        hint: "ISO ...",
        value: "ISO 121212, ISO 121212"),
  ],
);

class AgencyRepositoryFake extends AgencyRepository {
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
    List<AgencyEntity> agencies = [
      fakeAgency,
      fakeAgent2,
      fakeAgent3,
    ];
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
          name: "Random Agency",
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
