import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/main_controller.dart';
import 'package:principle_fe/app/ui/pages/stocks/stock_page.dart';
import 'package:principle_fe/app/ui/pages/tradings/trading_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.title});

  final String title;

  static List<Widget> tabPages = <Widget>[
    const StocksPage(),
    const TradingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Obx(() => SafeArea(child: tabPages[controller.tabIndex.value])),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        currentIndex: controller.tabIndex.value,
        onTap: controller.setTabIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Tab1'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Tab2'),
        ],
      ),
    );
  }
}
