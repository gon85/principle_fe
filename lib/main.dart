import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
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
