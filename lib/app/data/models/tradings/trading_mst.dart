import 'package:principle_fe/app/data/models/tradings/trading_trx.dart';

class TradingMst {
  int? id;
  int? userId;
  String? isuSrtCd;
  int? avgBuyPrice;
  int? sumBuyCnt;
  int? avgSellPrice;
  int? sumSellCnt;
  int? remainCount;
  String? startedAt;
  String? finishedAt;
  String? createdAt;
  String? updatedAt;
  List<TradingTrx>? tradingTrxes;

  TradingMst(
      {this.id,
      this.userId,
      this.isuSrtCd,
      this.avgBuyPrice,
      this.sumBuyCnt,
      this.avgSellPrice,
      this.sumSellCnt,
      this.remainCount,
      this.startedAt,
      this.finishedAt,
      this.createdAt,
      this.updatedAt,
      this.tradingTrxes});

  TradingMst.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    isuSrtCd = json["isuSrtCd"];
    avgBuyPrice = json["avgBuyPrice"];
    sumBuyCnt = json["sumBuyCnt"];
    avgSellPrice = json["avgSellPrice"];
    sumSellCnt = json["sumSellCnt"];
    remainCount = json["remainCount"];
    startedAt = json["startedAt"];
    finishedAt = json["finishedAt"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    tradingTrxes = json["tradingTrxes"] == null
        ? null
        : (json["tradingTrxes"] as List)
            .map((e) => TradingTrx.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["userId"] = userId;
    data["isuSrtCd"] = isuSrtCd;
    data["avgBuyPrice"] = avgBuyPrice;
    data["sumBuyCnt"] = sumBuyCnt;
    data["avgSellPrice"] = avgSellPrice;
    data["sumSellCnt"] = sumSellCnt;
    data["remainCount"] = remainCount;
    data["startedAt"] = startedAt;
    data["finishedAt"] = finishedAt;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    if (tradingTrxes != null) {
      data["tradingTrxes"] = tradingTrxes?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
