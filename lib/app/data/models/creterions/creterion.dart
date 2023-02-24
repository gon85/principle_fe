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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["targetProfitRatio"] = targetProfitRatio;
    data["maxLossRatio"] = maxLossRatio;
    data["investmentPeriod"] = investmentPeriod;
    data["investmentPeriodUnit"] = investmentPeriodUnit;
    data["maxHoldCorpCnt"] = maxHoldCorpCnt;
    data["maxBuyingAmount"] = maxBuyingAmount;
    data["maxFocusInterestCnt"] = maxFocusInterestCnt;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    return data;
  }
}
