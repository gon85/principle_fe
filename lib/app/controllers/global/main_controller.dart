import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();

  final tabIndex = 0.obs;

  void setTabIndex(int index) {
    tabIndex(index);
  }
}
