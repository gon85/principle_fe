import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/tmp_controller.dart';

class TmpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TmpController>(() {
      return TmpController();
    });
  }
}
