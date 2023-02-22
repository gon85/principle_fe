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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["isuSrtCd"] = isuSrtCd;
    _data["baseDt"] = baseDt;
    _data["clpr"] = clpr;
    _data["mkp"] = mkp;
    _data["hipr"] = hipr;
    _data["lopr"] = lopr;
    _data["trqu"] = trqu;
    return _data;
  }
}
