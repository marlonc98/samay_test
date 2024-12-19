class AgencyEntity {
  String id;
  String name;
  String? hexColor;
  String logo;

  AgencyEntity({
    required this.id,
    required this.name,
    this.hexColor,
    required this.logo,
  });
}
