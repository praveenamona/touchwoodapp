class Paging {
  String totalCount;
  String pageSize;
  String currentPage;
  String totalPages;
  String previousPage;
  String nextPage;
  Paging(
      {this.currentPage,
      this.pageSize,
      this.nextPage,
      this.previousPage,
      this.totalCount,
      this.totalPages});
  Paging.fromJSON(Map<String, dynamic> jsonMap)
      : totalCount = jsonMap['totalCount'].toString(),
        pageSize = jsonMap['pageSize'].toString(),
        currentPage = jsonMap['currentPage'].toString(),
        totalPages = jsonMap['totalPages'].toString(),
        nextPage = jsonMap['nextPage'].toString(),
        previousPage = jsonMap['previousPage'].toString();
}
