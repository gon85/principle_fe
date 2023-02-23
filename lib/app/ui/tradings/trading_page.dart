import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_controller.dart';

class TradingPage extends StatelessWidget {
  // GetView<TradingController> {
  const TradingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TradingController());

    return Container(
        padding: const EdgeInsets.all(16),
        child: GetX<TradingController>(
          initState: (state) => TradingController.to,
          builder: (controller) {
            return Text('Trading Main ${TradingController.to.title}');
          },
        ));
  }
}
