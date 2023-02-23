class Creterion {
  int? userId;
  int? targetProfitRatio;
  int? maxLossRatio;
  int? investmentPeriod;
  String? investmentPeriodUnit;
  int? maxHoldCorpCnt;
  int? maxBuyingAmount;
  int? maxFocusInterestCnt;
  String? createdAt;
  String? updatedAt;

  Creterion(
      {this.userId,
      this.targetProfitRatio,
      this.maxLossRatio,
      this.investmentPeriod,
      this.investmentPeriodUnit,
      this.maxHoldCorpCnt,
      this.maxBuyingAmount,
      this.maxFocusInterestCnt,
      this.createdAt,
      this.updatedAt});

  Creterion.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    targetProfitRatio = json["targetProfitRatio"];
    maxLossRatio = json["maxLossRatio"];
    investmentPeriod = json["investmentPeriod"];
    investmentPeriodUnit = json["investmentPeriodUnit"];
    maxHoldCorpCnt = json["maxHoldCorpCnt"];
    maxBuyingAmount = json["maxBuyingAmount"];
    maxFocusInterestCnt = json["maxFocusInterestCnt"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["targetProfitRatio"] = targetProfitRatio;
    _data["maxLossRatio"] = maxLossRatio;
    _data["investmentPeriod"] = investmentPeriod;
    _data["investmentPeriodUnit"] = investmentPeriodUnit;
    _data["maxHoldCorpCnt"] = maxHoldCorpCnt;
    _data["maxBuyingAmount"] = maxBuyingAmount;
    _data["maxFocusInterestCnt"] = maxFocusInterestCnt;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
}
