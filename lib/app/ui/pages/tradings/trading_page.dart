import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/tradings/trading_controller.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/app/data/repositories/tradings/trading_repository.dart';
import 'package:principle_fe/utils/logs/logger.dart';
import 'package:principle_fe/utils/numbers/number_uttils.dart';

class TradingPage extends StatelessWidget {
  // GetView<TradingController> {
  const TradingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
        TradingController(tradingRepo: TradingRepository(restApi: RestApi())));

    return Container(
        padding: const EdgeInsets.all(10),
        child: GetX<TradingController>(
          initState: (state) => TradingController.to,
          builder: (controller) {
            // return Text('Trading Main ${TradingController.to.title}');
            return ListView.builder(
              padding: const EdgeInsets.all(1),
              itemCount: TradingController.to.tradings.length,
              itemBuilder: (context, index) => Obx(() {
                final tmTarget = TradingController.to.tradings[index];
                return Card(
                    key: ValueKey(index),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Text('${tmTarget.isuSrtCd}'),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _renderColumnNumers([
                                            tmTarget.avgBuyPrice as num,
                                            tmTarget.sumBuyCnt as num
                                          ]),
                                        ),
                                        Expanded(
                                            child: _renderColumnNumers([
                                          tmTarget.avgSellPrice as num,
                                          tmTarget.sumSellCnt as num
                                        ])),
                                        Expanded(
                                          child: _renderColumnNumers([
                                            (tmTarget.avgBuyPrice! -
                                                tmTarget.avgSellPrice!),
                                            tmTarget.remainCount as num
                                          ]),
                                        )
                                      ],
                                    )))
                          ],
                        ),
                        Positioned(
                          right: -5,
                          top: 0,
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              iconSize: 15,
                              icon: const Icon(
                                CupertinoIcons.ellipsis_vertical,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ));
              }),
            );
          },
        ));
  }

  Widget _renderColumnNumers(List<num> nums) {
    return Container(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(nums.length,
              (index) => Text('${NumberUtils.to.format(nums[index])}')),
        ));
  }
}
