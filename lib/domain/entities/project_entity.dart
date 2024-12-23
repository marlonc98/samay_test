import 'package:samay/domain/entities/aditional_field_entity.dart';
import 'package:samay/domain/entities/agency_entity.dart';

class ProjectEntity {
  String id;
  String agencyId;
  AgencyEntity? agency;
  String location;
  int price;
  String imageUrl;
  String? description;
  String name;
  List<AditionalFieldEntity> aditionalFields;

  ProjectEntity({
    required this.id,
    required this.agencyId,
    this.agency,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.description,
    required this.name,
    this.aditionalFields = const [],
  });
}
