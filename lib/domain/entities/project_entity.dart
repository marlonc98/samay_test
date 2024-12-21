import 'package:samay/domain/entities/agency_entity.dart';

class ProjectEntity {
  String id;
  String agencyId;
  AgencyEntity? agency;
  String location;
  double price;
  String imageUrl;
  String? description;
  String name;

  ProjectEntity({
    required this.id,
    required this.agencyId,
    this.agency,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.description,
    required this.name,
  });
}
