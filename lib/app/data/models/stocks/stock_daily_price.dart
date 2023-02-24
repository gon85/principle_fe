class StockDailyPrices {
  String? isuSrtCd;
  late String baseDt;
  late num clpr;
  late num mkp;
  late num hipr;
  late num lopr;
  String? trqu;

  StockDailyPrices(
      {this.isuSrtCd,
      required this.baseDt,
      required this.clpr,
      required this.mkp,
      required this.hipr,
      required this.lopr,
      this.trqu});

  StockDailyPrices.fromJson(Map<String, dynamic> json) {
    if (json["isuSrtCd"] is String) {
      isuSrtCd = json["isuSrtCd"];
    }
    baseDt = json["baseDt"];
    clpr = json["clpr"];
    mkp = json["mkp"];
    hipr = json["hipr"];
    lopr = json["lopr"];
    if (json["trqu"] is String) {
      trqu = json["trqu"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isuSrtCd"] = isuSrtCd;
    data["baseDt"] = baseDt;
    data["clpr"] = clpr;
    data["mkp"] = mkp;
    data["hipr"] = hipr;
    data["lopr"] = lopr;
    data["trqu"] = trqu;
    return data;
  }
}
