class ProjectFilterEntity {
  int? minPrice;
  int? maxPrice;
  String? agencyId;
  String? location;
  String? querySearch;

  ProjectFilterEntity({
    this.minPrice,
    this.maxPrice,
    this.querySearch,
    this.location,
    this.agencyId,
  });

  @override
  String toString() {
    return 'ProjectFilterEntity{minPrice: $minPrice, maxPrice: $maxPrice, agencyId: $agencyId, location: $location, querySearch: $querySearch}';
  }
}
