import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
import 'package:principle_fe/app/controllers/global/count_controller.dart';
import 'package:principle_fe/app/data/providers/auth_api.dart';
import 'package:principle_fe/app/data/repositories/auth/auth_repository.dart';
import 'package:principle_fe/app/routes/app_pages.dart';

void main() async {
  const mode = String.fromEnvironment(
    'ENV',
    defaultValue: 'local',
  );
  if (mode == 'prod') {
    await dotenv.load(fileName: 'assets/configs/.env');
  } else {
    await dotenv.load(fileName: 'assets/configs/.env.$mode');
  }

  Get.put(AuthController(
    authRepo: AuthenticationRepository(
      authApi: AuthApi(),
    ),
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

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
            // GetBuilder<CounterSimpleController>(builder: (controller) {
            //   return Text(
            //     '${controller.count}',
            //     style: Theme.of(context).textTheme.headlineMedium,
            //   );
            // })
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
