import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class TradingDetailController extends GetxController {
  static TradingDetailController get to => Get.find<TradingDetailController>();

  TradingDetailController();

  final formKey = GlobalKey<FormState>();
  final title = '매매상세'.obs;

  @override
  void onInit() {
    super.onInit();
    logger.i('detil init!!!!!');
  }
}
