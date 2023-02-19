import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() {
      return SplashController();
    });
  }
}
