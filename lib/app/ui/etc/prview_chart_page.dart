import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:principle_fe/app/data/models/stocks/stock_daily_price.dart';
import 'package:principle_fe/app/data/models/stocks/stock_daily_price_info.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/utils/logs/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class PreviewChartPage extends StatefulWidget {
  const PreviewChartPage({Key? key}) : super(key: key);

  @override
  State<PreviewChartPage> createState() => _PreviewChartPageState();
}

class _PreviewChartPageState extends State<PreviewChartPage> {
  late StockDailyPriceInfo _sdp;
  List<StockDailyPrices> _prices = [];

  @override
  void initState() {
    super.initState();
    // rootBundle.loadString('assets/data.json').then((json) {
    //   final items = jsonDecode(json) as List<dynamic>;
    // });
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString('accessToken');
      if (token != null) {
        final restApi = RestApi(token);
        restApi
            .getStockDailyPriceInfo(isuSrtCd: 'KOSPI', isuCd: 'KOSPI')
            .then((rep) {
          _sdp = StockDailyPriceInfo.fromJson(rep.body);
          setState(() {
            _prices.addAll(_sdp.stockDailyPrices.reversed);
          });
          // loggerStack.d(rep.body);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CustomScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic'),
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 350,
              height: 300,
              child: (_prices.isEmpty)
                  ? const Text('loading..')
                  : Chart(
                      data: _prices, // stockData.reversed.toList(),
                      variables: {
                        'baseDt': Variable(
                          accessor: (StockDailyPrices datumn) => datumn.baseDt,
                          scale: OrdinalScale(tickCount: 4),
                        ),
                        'mkp': Variable(
                          // start
                          accessor: (StockDailyPrices datumn) => datumn.mkp,
                          scale: LinearScale(min: 2400, max: 2500),
                        ),
                        'hipr': Variable(
                          accessor: (StockDailyPrices datumn) => datumn.hipr,
                          scale: LinearScale(min: 2400, max: 2500),
                        ),
                        'lopr': Variable(
                          accessor: (StockDailyPrices datumn) => datumn.lopr,
                          scale: LinearScale(min: 2400, max: 2500),
                        ),
                        'clpr': Variable(
                          accessor: (StockDailyPrices datumn) => datumn.clpr,
                          scale: LinearScale(min: 2400, max: 2500),
                        ),
                      },
                      elements: [
                        CustomElement(
                          shape: ShapeAttr(value: CandlestickShape()),
                          position: Varset('baseDt') *
                              (Varset('mkp') +
                                  Varset('hipr') +
                                  Varset('lopr') +
                                  Varset('clpr')),
                          color: ColorAttr(
                              encoder: (tuple) => tuple['clpr'] >= tuple['mkp']
                                  ? Colors.red
                                  : Colors.green),
                        )
                      ],
                      axes: [
                        Defaults.horizontalAxis,
                        Defaults.verticalAxis,
                      ],
                      coord: RectCoord(
                          horizontalRangeUpdater:
                              Defaults.horizontalRangeSignal),
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}

const stockData = [
  {
    'time': '2015-11-19',
    'start': 8.18,
    'max': 8.33,
    'min': 7.98,
    'end': 8.32,
    'volume': 1810,
    'money': 14723.56
  },
  {
    'time': '2015-11-18',
    'start': 8.37,
    'max': 8.6,
    'min': 8.03,
    'end': 8.09,
    'volume': 2790.37,
    'money': 23309.19
  },
  {
    'time': '2015-11-17',
    'start': 8.7,
    'max': 8.78,
    'min': 8.32,
    'end': 8.37,
    'volume': 3729.04,
    'money': 31709.71
  },
  {
    'time': '2015-11-16',
    'start': 8.18,
    'max': 8.69,
    'min': 8.05,
    'end': 8.62,
    'volume': 3095.44,
    'money': 26100.69
  },
  {
    'time': '2015-11-13',
    'start': 8.01,
    'max': 8.75,
    'min': 7.97,
    'end': 8.41,
    'volume': 5815.58,
    'money': 48562.37
  },
  {
    'time': '2015-11-12',
    'start': 7.76,
    'max': 8.18,
    'min': 7.61,
    'end': 8.15,
    'volume': 4742.6,
    'money': 37565.36
  },
  {
    'time': '2015-11-11',
    'start': 7.55,
    'max': 7.81,
    'min': 7.49,
    'end': 7.8,
    'volume': 3133.82,
    'money': 24065.42
  },
  {
    'time': '2015-11-10',
    'start': 7.5,
    'max': 7.68,
    'min': 7.44,
    'end': 7.57,
    'volume': 2670.35,
    'money': 20210.58
  },
  {
    'time': '2015-11-09',
    'start': 7.65,
    'max': 7.66,
    'min': 7.3,
    'end': 7.58,
    'volume': 2841.79,
    'money': 21344.36
  },
  {
    'time': '2015-11-06',
    'start': 7.52,
    'max': 7.71,
    'min': 7.48,
    'end': 7.64,
    'volume': 2725.44,
    'money': 20721.51
  },
  {
    'time': '2015-11-05',
    'start': 7.48,
    'max': 7.57,
    'min': 7.29,
    'end': 7.48,
    'volume': 3520.85,
    'money': 26140.83
  },
  {
    'time': '2015-11-04',
    'start': 7.01,
    'max': 7.5,
    'min': 7.01,
    'end': 7.46,
    'volume': 3591.47,
    'money': 26285.52
  },
  {
    'time': '2015-11-03',
    'start': 7.1,
    'max': 7.17,
    'min': 6.82,
    'end': 7,
    'volume': 2029.21,
    'money': 14202.33
  },
  {
    'time': '2015-11-02',
    'start': 7.09,
    'max': 7.44,
    'min': 6.93,
    'end': 7.17,
    'volume': 3191.31,
    'money': 23205.11
  },
  {
    'time': '2015-10-30',
    'start': 6.98,
    'max': 7.27,
    'min': 6.84,
    'end': 7.18,
    'volume': 3522.61,
    'money': 25083.44
  },
  {
    'time': '2015-10-29',
    'start': 6.94,
    'max': 7.2,
    'min': 6.8,
    'end': 7.05,
    'volume': 2752.27,
    'money': 19328.44
  },
  {
    'time': '2015-10-28',
    'start': 7.01,
    'max': 7.14,
    'min': 6.8,
    'end': 6.85,
    'volume': 2311.11,
    'money': 16137.32
  },
  {
    'time': '2015-10-27',
    'start': 6.91,
    'max': 7.31,
    'min': 6.48,
    'end': 7.18,
    'volume': 3172.9,
    'money': 21827.3
  },
  {
    'time': '2015-10-26',
    'start': 6.9,
    'max': 7.08,
    'min': 6.87,
    'end': 6.95,
    'volume': 2769.31,
    'money': 19337.44
  },
  {
    'time': '2015-10-23',
    'start': 6.71,
    'max': 6.85,
    'min': 6.58,
    'end': 6.79,
    'volume': 2483.18,
    'money': 16714.31
  },
  {
    'time': '2015-10-22',
    'start': 6.38,
    'max': 6.67,
    'min': 6.34,
    'end': 6.65,
    'volume': 2225.88,
    'money': 14465.56
  },
];
