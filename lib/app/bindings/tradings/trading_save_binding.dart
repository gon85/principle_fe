import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_save_controller.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/app/data/repositories/tradings/trading_repository.dart';

class TradingSaveBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TradingSaveController>(() {
      return TradingSaveController(
          tradingRepo: TradingRepository(restApi: RestApi()));
    });
  }
}
