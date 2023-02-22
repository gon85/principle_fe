import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestApi extends GetConnect {
  late String accessToken;

  RestApi(this.accessToken);

  Future<Response<T>> _get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    headers ??= {};
    headers['Authorization'] = 'Bearer $accessToken';
    return get(url,
        headers: headers,
        contentType: contentType,
        query: query,
        decoder: decoder);
  }
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

  Future<Response> getStockDailyPriceInfo({
    required String isuSrtCd,
    required String isuCd,
    String? fromDate,
    String? toDate,
  }) async {
    return _get('${dotenv.env['API_URL']}/api/stocks/daily', query: {
      'isuSrtCd': isuSrtCd,
      'isuCd': isuCd,
      'fromDate': fromDate,
      'toDate': toDate
    });
  }
}
