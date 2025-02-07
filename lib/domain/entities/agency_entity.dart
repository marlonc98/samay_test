import 'package:samay/domain/entities/aditional_field_entity.dart';

class AgencyEntity {
  String id;
  String name;
  String? hexColor;
  String logo;
  List<AditionalFieldEntity> aditionalFields;

  AgencyEntity({
    required this.id,
    required this.name,
    this.hexColor,
    required this.logo,
    required this.aditionalFields,
  });

  @override
  String toString() {
    return 'AgencyEntity{id: $id, name: $name, hexColor: $hexColor, logo: $logo, aditionalFields: $aditionalFields}';
  }
}
