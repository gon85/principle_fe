import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
import 'package:principle_fe/app/routes/app_pages.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  void onReady() async {
    super.onReady();

    AuthController authController = Get.find<AuthController>();
    await authController.hasToken(1);
    if (AuthController.to.authStatus == AuthenticationStatus.authenticated) {
      Get.offNamed(AppRoutes.home);
    } else {
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
