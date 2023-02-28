import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_detail_controller.dart';

class TradingDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TradingDetailController>(() => TradingDetailController());
  }
}
