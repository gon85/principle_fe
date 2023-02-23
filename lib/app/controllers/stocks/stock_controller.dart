import 'package:get/get.dart';

class StocksController extends GetxController {
  static StocksController get to => Get.find<StocksController>();

  final title = '메인-차트'.obs;
}
