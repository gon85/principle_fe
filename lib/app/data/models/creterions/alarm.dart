class Alarms {
  int? userId;
  String? alarmCategoryCd;
  String? time;
  int? isUse;
  String? createdAt;
  String? updatedAt;

  Alarms(
      {this.userId,
      this.alarmCategoryCd,
      this.time,
      this.isUse,
      this.createdAt,
      this.updatedAt});

  Alarms.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    alarmCategoryCd = json["alarmCategoryCd"];
    time = json["time"];
    isUse = json["isUse"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["alarmCategoryCd"] = alarmCategoryCd;
    data["time"] = time;
    data["isUse"] = isUse;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    return data;
  }
}
