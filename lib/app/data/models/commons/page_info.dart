class PageInfo {
  int? page;
  int? totalCount;
  int? countPerPage;
  int? countOfDisplayPageNo;

  PageInfo(
      {this.page,
      this.totalCount,
      this.countPerPage,
      this.countOfDisplayPageNo});

  PageInfo.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    totalCount = json["totalCount"];
    countPerPage = json["countPerPage"];
    countOfDisplayPageNo = json["countOfDisplayPageNo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["page"] = page;
    data["totalCount"] = totalCount;
    data["countPerPage"] = countPerPage;
    data["countOfDisplayPageNo"] = countOfDisplayPageNo;
    return data;
  }

  static get defaultInstance {
    return PageInfo(
        page: 1, totalCount: 0, countPerPage: 100, countOfDisplayPageNo: 10);
  }
}
