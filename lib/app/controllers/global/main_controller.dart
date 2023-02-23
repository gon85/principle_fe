import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();

  final tabIndex = 0.obs;

  @override
  void onReady() async {
    super.onReady();

    await AuthController.to.getUserCreterionsInfo();
  }

  void setTabIndex(int index) {
    tabIndex(index);
  }
}
