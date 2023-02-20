import 'package:get/get.dart';
import 'package:principle_fe/app/routes/app_pages.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class CounterSimpleController extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update();
  }
}

class CounterResponsiveController extends GetxController {
  final count = 0.obs;

  void increment() {
    count.value++;
    // count(count.value + 1);
  }

  void moveToPreviewChart() {
    logger.i('----> move to preview chart');
    Get.toNamed(AppRoutes.previewChart);
  }
}
