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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["alarmCategoryCd"] = alarmCategoryCd;
    _data["time"] = time;
    _data["isUse"] = isUse;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
}
