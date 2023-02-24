import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
import 'package:principle_fe/app/routes/app_pages.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  final stepMessage = 'initialize'.obs;

  @override
  void onReady() async {
    super.onReady();

    AuthController authController = Get.find<AuthController>();
    await authController.hasToken(1);
    stepMessage.value = 'initialize user info';
    if (AuthController.to.authStatus == AuthenticationStatus.authenticated) {
      await AuthController.to.getUserCreterionsInfo();
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
