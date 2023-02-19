import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
import 'package:principle_fe/app/controllers/global/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController.to;
    return Scaffold(
        body: Center(
            child: Obx(() =>
                AuthController.to.authStatus == AuthenticationStatus.unknown
                    ? const Text('checked login')
                    : const Text('required login'))));
  }
}
