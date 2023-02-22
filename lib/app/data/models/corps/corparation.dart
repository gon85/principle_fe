class Corparation {
  late String isuSrtCd;
  late String isuCd;
  String? isuAbbrv;
  String? kindStkcertTpNm;
  late String isuNm;
  String? isuNmDisassemble;
  String? corpCode;
  String? createdAt;
  String? updatedAt;

  Corparation(
      {required this.isuSrtCd,
      required this.isuCd,
      this.isuAbbrv,
      this.kindStkcertTpNm,
      required this.isuNm,
      this.isuNmDisassemble,
      this.corpCode,
      this.createdAt,
      this.updatedAt});

  Corparation.fromJson(Map<String, dynamic> json) {
    isuSrtCd = json["isuSrtCd"];
    isuCd = json["isuCd"];
    if (json["isuAbbrv"] is String) {
      isuAbbrv = json["isuAbbrv"];
    }
    if (json["kindStkcertTpNm"] is String) {
      kindStkcertTpNm = json["kindStkcertTpNm"];
    }
    isuNm = json["isuNm"];
    if (json["isuNmDisassemble"] is String) {
      isuNmDisassemble = json["isuNmDisassemble"];
    }
    if (json["corpCode"] is String) {
      corpCode = json["corpCode"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["isuSrtCd"] = isuSrtCd;
    _data["isuCd"] = isuCd;
    _data["isuAbbrv"] = isuAbbrv;
    _data["kindStkcertTpNm"] = kindStkcertTpNm;
    _data["isuNm"] = isuNm;
    _data["isuNmDisassemble"] = isuNmDisassemble;
    _data["corpCode"] = corpCode;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
}
