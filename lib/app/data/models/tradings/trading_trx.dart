class TradingTrx {
  int? id;
  int? tradingId;
  String? isuSrtCd;
  String? tradingTypeCd;
  String? tradingDate;
  String? tradingTime;
  int? price;
  int? cnt;
  String? tradingAt;
  String? createdAt;

  TradingTrx(
      {this.id,
      this.tradingId,
      this.isuSrtCd,
      this.tradingTypeCd,
      this.tradingDate,
      this.tradingTime,
      this.price,
      this.cnt,
      this.tradingAt,
      this.createdAt});

  TradingTrx.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tradingId = json["tradingId"];
    isuSrtCd = json["isuSrtCd"];
    tradingTypeCd = json["tradingTypeCd"];
    tradingDate = json["tradingDate"];
    tradingTime = json["tradingTime"];
    price = json["price"];
    cnt = json["cnt"];
    tradingAt = json["tradingAt"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["tradingId"] = tradingId;
    data["isuSrtCd"] = isuSrtCd;
    data["tradingTypeCd"] = tradingTypeCd;
    data["tradingDate"] = tradingDate;
    data["tradingTime"] = tradingTime;
    data["price"] = price;
    data["cnt"] = cnt;
    data["tradingAt"] = tradingAt;
    data["createdAt"] = createdAt;
    return data;
  }
}
