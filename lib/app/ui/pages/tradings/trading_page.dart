import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/global_controller.dart';
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
        title: Text('${TradingController.to.title}'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<TradingController>(
            initState: (state) => TradingController.to,
            builder: (controller) {
              return RefreshIndicator(
                  onRefresh: TradingController.to.onRefresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(1),
                    itemCount: TradingController.to.tradings.length,
                    itemBuilder: (context, index) => Obx(() {
                      final tmTarget = TradingController.to.tradings[index];
                      final corpTarget =
                          GlobalController.to.findOne(tmTarget.isuSrtCd!);
                      return TradingCard(
                        tmTarget: tmTarget,
                        corpName: corpTarget?.isuAbbrv,
                        onPressed: () {
                          logger.i('trading card pressed!!!');
                          // Get.toNamed(AppRoutes.tradingsSave,
                          //     arguments: tmTarget);
                        },
                      );
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      bool isVisible = false;
                      if (0 < index &&
                          index < TradingController.to.tradings.length - 1) {
                        final tmCurrent = TradingController.to.tradings[index];
                        final tmNext = TradingController.to.tradings[index + 1];
                        if (tmCurrent.remainCount! > 0 &&
                            tmNext.remainCount! <= 0) {
                          isVisible = true;
                        }
                      }
                      return isVisible
                          ? const Text('완료된 거래')
                          : DividerVisiblity(
                              isVisible: isVisible,
                              height: isVisible ? 1 : 0,
                              thickness: isVisible ? 1 : 0,
                            );
                    },
                  ));
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
