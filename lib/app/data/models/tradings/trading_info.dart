import 'package:principle_fe/app/data/models/commons/page_info.dart';
import 'package:principle_fe/app/data/models/tradings/trading_mst.dart';

class TradingInfo {
  late List<TradingMst> list;
  late PageInfo pageInfo;

  TradingInfo({required this.list, required this.pageInfo});

  TradingInfo.fromJson(Map<String, dynamic> json) {
    list = (json["list"] as List).map((e) => TradingMst.fromJson(e)).toList();
    pageInfo = PageInfo.fromJson(json["pageInfo"]);
  }

  set value(TradingInfo value) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["list"] = list.map((e) => e.toJson()).toList();
    data["pageInfo"] = pageInfo.toJson();
    return data;
  }
}
