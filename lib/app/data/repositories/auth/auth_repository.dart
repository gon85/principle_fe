import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:principle_fe/app/data/models/authentications/auth.dart';
import 'package:principle_fe/app/data/models/errors/error_response.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/providers/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  final AuthApi authApi;

  AuthenticationRepository({required this.authApi});

  Future<AuthModel> authentificate({
    required String email,
    required String pw,
  }) async {
    final rep = await authApi.authenticate(email: email, pw: pw);

    if (rep.statusCode == HttpStatus.created) {
      AuthModel am = AuthModel.fromJson(rep.body, email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', am.accessToken);
      return am;
    } else {
      ErrorResponse er = ErrorResponse.fromJson(rep.statusCode!, rep.body);
      throw ResponseException(er);
    }
  }

  // Future<void> deleteToken() async {
  //   /// delete from keystore/keychain
  //   await Future.delayed(const Duration(seconds: 1));
  //   return;
  // }

  // Future<void> persistToken(String token) async {
  //   /// write to keystore/keychain
  //   await Future.delayed(const Duration(seconds: 1));
  //   return;
  // }

  Future<String?> getToken([int delaySeconds = 0]) async {
    if (delaySeconds > 0) {
      await Future.delayed(Duration(seconds: delaySeconds));
    }
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    if (token == null || token.isEmpty) return null;

    DateTime? expiryDate = Jwt.getExpiryDate(token);
    debugPrint('----> expiryDate : $expiryDate');
    if (expiryDate == null) return null;
    if (DateTime.now().isAfter(expiryDate)) {
      prefs.remove('accessToken');
      return null;
    }

    return token;
  }

  Future<bool> hasToken([int delaySeconds = 0]) async {
    /// read from keystore/keychain
    // if (delaySeconds > 0) {
    //   await Future.delayed(Duration(seconds: delaySeconds));
    // }
    // final prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('accessToken');
    String? token = await getToken(delaySeconds);
    if (token == null || token.isEmpty) return false;

    return true;
  }
}
