import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/stocks/stock_controller.dart';

class StocksPage extends GetView<StocksController> {
  const StocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StocksController());

    return Container(
      padding: const EdgeInsets.all(16),
      child: GetX<StocksController>(
        initState: (state) => StocksController.to,
        builder: (controller) {
          return Text('Stock Main ${StocksController.to.title}');
        },
      ),
    );
  }
}
