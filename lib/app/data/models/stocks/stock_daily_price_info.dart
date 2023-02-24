import 'package:principle_fe/app/data/models/corps/corparation.dart';
import 'package:principle_fe/app/data/models/stocks/stock_daily_price.dart';

class StockDailyPriceInfo {
  late Corparation corparation;
  UserCorpStats? userCorpStats;
  late List<StockDailyPrices> stockDailyPrices;

  StockDailyPriceInfo(
      {required this.corparation,
      this.userCorpStats,
      required this.stockDailyPrices});

  StockDailyPriceInfo.fromJson(Map<String, dynamic> json) {
    corparation = Corparation.fromJson(json["corparation"]);
    if (json["userCorpStats"] is Map) {
      userCorpStats = json["userCorpStats"] == null
          ? null
          : UserCorpStats.fromJson(json["userCorpStats"]);
    }
    stockDailyPrices = (json["stockDailyPrices"] as List)
        .map((e) => StockDailyPrices.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["corparation"] = corparation.toJson();
    if (userCorpStats != null) {
      data["userCorpStats"] = userCorpStats?.toJson();
    }
    data["stockDailyPrices"] = stockDailyPrices.map((e) => e.toJson()).toList();
    return data;
  }
}

class UserCorpStats {
  int? userId;
  String? isuSrtCd;
  int? hstCount;
  int? hstCountTm;
  String? hstLastAt;
  int? favoriteCount;
  dynamic favoriteLastAt;

  UserCorpStats(
      {this.userId,
      this.isuSrtCd,
      this.hstCount,
      this.hstCountTm,
      this.hstLastAt,
      this.favoriteCount,
      this.favoriteLastAt});

  UserCorpStats.fromJson(Map<String, dynamic> json) {
    if (json["userId"] is int) {
      userId = json["userId"];
    }
    if (json["isuSrtCd"] is String) {
      isuSrtCd = json["isuSrtCd"];
    }
    if (json["hstCount"] is int) {
      hstCount = json["hstCount"];
    }
    if (json["hstCountTm"] is int) {
      hstCountTm = json["hstCountTm"];
    }
    if (json["hstLastAt"] is String) {
      hstLastAt = json["hstLastAt"];
    }
    if (json["favoriteCount"] is int) {
      favoriteCount = json["favoriteCount"];
    }
    favoriteLastAt = json["favoriteLastAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["isuSrtCd"] = isuSrtCd;
    data["hstCount"] = hstCount;
    data["hstCountTm"] = hstCountTm;
    data["hstLastAt"] = hstLastAt;
    data["favoriteCount"] = favoriteCount;
    data["favoriteLastAt"] = favoriteLastAt;
    return data;
  }
}
