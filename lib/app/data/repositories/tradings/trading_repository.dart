import 'dart:io';

import 'package:principle_fe/app/data/models/errors/error_response.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/models/tradings/trading_info.dart';
import 'package:principle_fe/app/data/models/tradings/trading_trx.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class TradingRepository {
  RestApi restApi;

  TradingRepository({required this.restApi});

  Future<TradingInfo> getTradingInfos() async {
    logger.i('----> getTradingInfos!!!');
    final rep = await restApi.getUserTradingInfo();

    if (rep.statusCode == HttpStatus.ok) {
      TradingInfo ti = TradingInfo.fromJson(rep.body);
      return ti;
    } else {
      ErrorResponse er = ErrorResponse.fromJson(rep.statusCode!, rep.body);
      throw ResponseException(er);
    }
  }

  Future<TradingInfo> saveTradingTrx(TradingTrx tt) async {
    logger.i('----> getTradingInfos!!!');
    final rep = await restApi.getUserTradingInfo();

    if (rep.statusCode == HttpStatus.ok) {
      TradingInfo ti = TradingInfo.fromJson(rep.body);
      return ti;
    } else {
      ErrorResponse er = ErrorResponse.fromJson(rep.statusCode!, rep.body);
      throw ResponseException(er);
    }
  }
}
