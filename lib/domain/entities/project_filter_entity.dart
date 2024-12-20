class ProjectFilterEntity {
  double? minPrice;
  double? maxPrice;
  String? agencyId;
  String? querySearch;

  ProjectFilterEntity({
    required this.minPrice,
    required this.maxPrice,
    required this.querySearch,
    this.agencyId,
  });
}
