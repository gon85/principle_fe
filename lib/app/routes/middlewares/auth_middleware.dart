import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/auth_controller.dart';
import 'package:principle_fe/app/routes/app_pages.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class _AuthGuard extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    logger.i('---------------onPageCalled');
    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    logger.i('---------------onPageCalled');
    return super.onBindingsStart(bindings);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    logger.i('---------------onPageBuildStart');
    return super.onPageBuildStart(page);
  }

  @override
  void onPageDispose() {
    logger.i('---------------onPageDispose');
    super.onPageDispose();
  }

  @override
  RouteSettings? redirect(String? route) {
    if (AuthController.to.authStatus != AuthenticationStatus.authenticated) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}

var authGuard = _AuthGuard();
