import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:principle_fe/app/data/models/tradings/trading_mst.dart';
import 'package:principle_fe/utils/numbers/number_uttils.dart';

class TradingCard extends StatelessWidget {
  const TradingCard({super.key, required this.tmTarget, this.onPressed});
  final TradingMst tmTarget;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Stack(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Text('${tmTarget.isuSrtCd}'),
                )),
            Expanded(
                flex: 3,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
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
                            (tmTarget.avgBuyPrice! - tmTarget.avgSellPrice!),
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
              onPressed: onPressed,
            ),
          ),
        ),
      ],
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
