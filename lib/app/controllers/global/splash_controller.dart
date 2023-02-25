import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/global_controller.dart';
import 'package:principle_fe/app/routes/app_pages.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  final stepMessage = 'initialize'.obs;

  @override
  void onReady() async {
    super.onReady();

    GlobalController authController = Get.find<GlobalController>();
    await authController.hasToken(1);
    stepMessage.value = 'initialize user info';
    if (GlobalController.to.authStatus == AuthenticationStatus.authenticated) {
      await GlobalController.to.init();
      // await Future.delayed(const Duration(seconds: 2));
      Get.offNamed(AppRoutes.home);
    } else {
      // await Future.delayed(const Duration(seconds: 2));
      Get.offNamed(AppRoutes.login);
    }
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('splash controller colse!!');
  }

  // void click() {
  //   Get.toNamed(AppRoutes.login);
  // }
}
