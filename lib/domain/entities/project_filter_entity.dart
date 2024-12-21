class ProjectFilterEntity {
  double? minPrice;
  double? maxPrice;
  String? agencyId;
  String? querySearch;

  ProjectFilterEntity({
    this.minPrice,
    this.maxPrice,
    this.querySearch,
    this.agencyId,
  });
}
