import 'package:get/get.dart';

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
}
