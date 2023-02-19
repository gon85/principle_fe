import 'package:get/get.dart';
import 'package:principle_fe/app/bindings/auth/login_binding.dart';
import 'package:principle_fe/app/bindings/splash_binding.dart';
import 'package:principle_fe/app/routes/middlewares/auth_middleware.dart';
import 'package:principle_fe/app/ui/auth/login_page.dart';
import 'package:principle_fe/app/ui/commons/splash_page.dart';
import 'package:principle_fe/main.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.home,
        page: () => const MyHomePage(title: 'principle'),
        middlewares: [authGuard]),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
