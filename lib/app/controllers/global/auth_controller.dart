import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:principle_fe/app/data/models/creterions/user_creterions_info.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/repositories/auth/auth_repository.dart';
import 'package:principle_fe/app/data/repositories/creterions/creterion_repository.dart';
import 'package:principle_fe/app/routes/app_pages.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();

  AuthController({required this.authRepo, required this.creterionRepo});

  final AuthenticationRepository authRepo;
  final CreterionRepository creterionRepo;

  final _authStatus = AuthenticationStatus.unknown.obs;
  final _creterionsInfo = UserCreterionsInfo().obs;

  AuthenticationStatus get authStatus => _authStatus.value;
  UserCreterionsInfo get creterionsInfo => _creterionsInfo.value;

  Future<void> authentificate({
    required String email,
    required String pw,
  }) async {
    try {
      await authRepo.authentificate(email: email, pw: pw);
      _authStatus.value = AuthenticationStatus.authenticated;
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }

  Future<void> hasToken([int delaySeconds = 0]) async {
    String? token = await authRepo.getToken(delaySeconds);
    if (token != null && token.isEmpty == false) {
      _authStatus.value = AuthenticationStatus.authenticated;
    } else {
      _authStatus.value = AuthenticationStatus.unauthenticated;
    }
  }

  Future<void> getUserCreterionsInfo() async {
    try {
      UserCreterionsInfo uci = await creterionRepo.getUserCreterionsInfo();
      _creterionsInfo.value = uci;
    } on ResponseException catch (er) {
      Fluttertoast.showToast(msg: er.message, toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: '${error.toString()}!!!');
    }
  }
}
