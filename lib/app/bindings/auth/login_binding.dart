import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/auth/login_controller.dart';
// import 'package:principle_fe/app/data/providers/auth_api.dart';
// import 'package:principle_fe/app/data/repositories/auth/auth_repository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() {
      return LoginController();
    });
  }
}
