import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/global_controller.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();

  final tabIndex = 0.obs;

  @override
  void onReady() async {
    super.onReady();

    await GlobalController.to.init();
  }

  void setTabIndex(int index) {
    tabIndex(index);
  }
}
