import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/count_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CounterSimpleController());
    final controller2 = Get.put(CounterResponsiveController());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            GestureDetector(
              onTap: controller2.moveToPreviewChart,
              child: const Text(
                'Simple Chart',
              ),
            ),
            Obx(() => Text(
                  '${controller2.count.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller2.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
