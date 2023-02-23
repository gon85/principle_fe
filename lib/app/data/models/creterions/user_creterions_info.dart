import 'package:principle_fe/app/data/models/creterions/alarm.dart';
import 'package:principle_fe/app/data/models/creterions/creterion.dart';

class UserCreterionsInfo {
  Creterion? creterion;
  List<Alarms>? alarms;

  UserCreterionsInfo({this.creterion, this.alarms});

  UserCreterionsInfo.fromJson(Map<String, dynamic> json) {
    creterion = json["creterion"] == null
        ? null
        : Creterion.fromJson(json["creterion"]);
    alarms = json["alarms"] == null
        ? null
        : (json["alarms"] as List).map((e) => Alarms.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (creterion != null) {
      data["creterion"] = creterion?.toJson();
    }
    if (alarms != null) {
      data["alarms"] = alarms?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
