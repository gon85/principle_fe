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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isuSrtCd"] = isuSrtCd;
    data["isuCd"] = isuCd;
    data["isuAbbrv"] = isuAbbrv;
    data["kindStkcertTpNm"] = kindStkcertTpNm;
    data["isuNm"] = isuNm;
    data["isuNmDisassemble"] = isuNmDisassemble;
    data["corpCode"] = corpCode;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    return data;
  }
}
