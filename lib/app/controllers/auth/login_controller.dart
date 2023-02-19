import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
import 'package:principle_fe/app/routes/app_pages.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  final formKey = GlobalKey<FormState>();
  String email = '';
  String pw = '';
  final dummy = ''.obs;

  void handlePressedLogin() async {
    final form = formKey.currentState;
    if (form?.validate() == null) return;

    formKey.currentState?.save();
    await AuthController.to.authentificate(email: email, pw: pw);
    if (AuthController.to.authStatus == AuthenticationStatus.authenticated) {
      Get.offNamed(AppRoutes.home);
    }
  }
}
