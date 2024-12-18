class SearchResultEntity<T> {
  int currentPage;
  int totalItems;
  List<T> data;
  int itemsPerPage;
  int lastpage;

  SearchResultEntity(
      {required this.currentPage,
      required this.totalItems,
      required this.data,
      required this.itemsPerPage,
      required this.lastpage});
}
