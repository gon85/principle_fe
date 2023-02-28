import 'package:get/get.dart';
import 'package:principle_fe/app/bindings/auth/login_binding.dart';
import 'package:principle_fe/app/bindings/splash_binding.dart';
import 'package:principle_fe/app/bindings/tmp_binding.dart';
import 'package:principle_fe/app/bindings/tradings/trading_detail_binding.dart';
import 'package:principle_fe/app/bindings/tradings/trading_save_binding.dart';
import 'package:principle_fe/app/routes/middlewares/auth_middleware.dart';
import 'package:principle_fe/app/ui/pages/auth/login_page.dart';
import 'package:principle_fe/app/ui/pages/etc/splash_page.dart';
import 'package:principle_fe/app/ui/pages/etc/prview_chart_page.dart';
import 'package:principle_fe/app/ui/pages/etc/tmp_page.dart';
import 'package:principle_fe/app/ui/pages/main_page.dart';
import 'package:principle_fe/app/ui/pages/tradings/trading_detail_page.dart';
import 'package:principle_fe/app/ui/pages/tradings/trading_save_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.home,
        page: () => const MainPage(title: 'principle'),
        middlewares: [authGuard]),
    GetPage(
        name: AppRoutes.previewChart,
        page: () => const PreviewChartPage(),
        middlewares: [authGuard]),
    GetPage(
      name: AppRoutes.tmp,
      page: () => const TmpPage(),
      middlewares: [authGuard],
      binding: TmpBinding(),
    ),
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
    GetPage(
        name: AppRoutes.tradingsSave,
        page: () => const TradingSavePage(),
        binding: TradingSaveBinding()),
    GetPage(
        name: AppRoutes.tradingsDetail,
        page: () => const TradingDetailPage(),
        binding: TradingDetailBinding()),
  ];
}
