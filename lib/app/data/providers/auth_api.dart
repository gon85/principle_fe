import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthApi extends GetConnect {
  // // Get request
  // Future<Response> getUser(int id) => get('http://youapi/users/$id');
  // // Post request
  // Future<Response> postUser(Map data) => post('http://youapi/users', body: data);
  // // Post request with File
  // Future<Response<CasesModel>> postCases(List<int> image) {
  //   final form = FormData({
  //     'file': MultipartFile(image, filename: 'avatar.png'),
  //     'otherFile': MultipartFile(image, filename: 'cover.png'),
  //   });
  //   return post('http://youapi/users/upload', form);
  // }

  // GetSocket userMessages() {
  //   return socket('https://yourapi/users/socket');
  // }

  Future<Response> authenticate({
    required String email,
    required String pw,
  }) async {
    debugPrint('$email, $pw');

    await Future.delayed(const Duration(seconds: 1));

    return post('${dotenv.env['API_URL']}/api/auth/login',
        jsonEncode(<String, String>{'email': email, 'pass': pw}));
  }
}
