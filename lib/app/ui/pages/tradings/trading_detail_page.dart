import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_detail_controller.dart';

class TradingDetailPage extends GetView<TradingDetailController> {
  const TradingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title.value)),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GetX<TradingDetailController>(
          initState: (state) => TradingDetailController.to,
          builder: (controller) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '??${TradingDetailController.to.title}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                  // Obx(() {
                  //   return TradingDetailController.to.title.value.isNotEmpty
                  //       ? Text(
                  //           '??${controller.title}',
                  //           style: Theme.of(context).textTheme.bodyMedium,
                  //         )
                  //       : const Text('xxx');
                  // })
                ]);
          },
        ),
      ),
    );
  }
}
