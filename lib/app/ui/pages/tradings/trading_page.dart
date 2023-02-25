import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_controller.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/app/data/repositories/tradings/trading_repository.dart';
import 'package:principle_fe/app/routes/app_pages.dart';
import 'package:principle_fe/app/ui/components/dividers/divider_visiblity.dart';
import 'package:principle_fe/app/ui/components/tradings/trading_card.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class TradingPage extends StatelessWidget {
  // GetView<TradingController> {
  const TradingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
        TradingController(tradingRepo: TradingRepository(restApi: RestApi())));

    return Scaffold(
      appBar: AppBar(
        title: Text('AAA'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<TradingController>(
            initState: (state) => TradingController.to,
            builder: (controller) {
              // return Text('Trading Main ${TradingController.to.title}');
              return ListView.separated(
                padding: const EdgeInsets.all(1),
                itemCount: TradingController.to.tradings.length,
                itemBuilder: (context, index) => Obx(() {
                  final tmTarget = TradingController.to.tradings[index];
                  return TradingCard(
                    tmTarget: tmTarget,
                    onPressed: () {
                      logger.i('trading card pressed!!!');
                    },
                  );
                }),
                separatorBuilder: (BuildContext context, int index) {
                  bool isVisible = false;
                  if (0 < index &&
                      index < TradingController.to.tradings.length - 1) {
                    final tmBefore = TradingController.to.tradings[index];
                    final tmCurrent = TradingController.to.tradings[index];
                    if (tmBefore.remainCount! > 0 &&
                        tmCurrent.remainCount! <= 0) {
                      isVisible = true;
                    }
                  }
                  return DividerVisiblity(
                    isVisible: isVisible,
                    height: 0,
                    thickness: 0,
                  );
                },
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.tradingsSave);
        },
        tooltip: '매매추가',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
