import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_controller.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/models/tradings/trading_info.dart';
import 'package:principle_fe/app/data/models/tradings/trading_trx.dart';
import 'package:principle_fe/app/data/repositories/tradings/trading_repository.dart';

class TradingSaveController extends GetxController {
  static TradingSaveController get to => Get.find<TradingSaveController>();

  TradingSaveController({required this.tradingRepo});

  final TradingRepository tradingRepo;

  final formKey = GlobalKey<FormState>();
  final title = '매매관리'.obs;
  final _tradingTrx = TradingTrx().obs;

  TradingTrx get tradingTrx {
    return _tradingTrx.value;
  }

  // @override
  // void onReady() async {
  //   super.onReady();
  // }

  void handlePressedSave() async {
    await saveTradingTrx();
  }

  Future<void> saveTradingTrx() async {
    try {
      TradingInfo tiTarget =
          await tradingRepo.saveTradingTrx(_tradingTrx.value);
      TradingController.to.tradingInfo.value = tiTarget;
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }
}
