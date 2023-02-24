import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestApi extends GetConnect {
  String? accessToken;

  RestApi._privateConstructor();
  static final RestApi _instance = RestApi._privateConstructor();

  factory RestApi() {
    return _instance;
  }

  Future<void> _init() async {
    if (accessToken == null) {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      accessToken = token ?? '';
    }
  }

  Future<Response<T>> _get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    await _init();
    headers ??= {};
    headers['Authorization'] = 'Bearer $accessToken';
    return get(url,
        headers: headers,
        contentType: contentType,
        query: query,
        decoder: decoder);
  }

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

  Future<Response> getUserCreterionInfo() async {
    return _get('${dotenv.env['API_URL']}/api/creterions', query: {});
  }

  Future<Response> getUserTradingInfo() async {
    return _get('${dotenv.env['API_URL']}/api/tradings', query: {});
  }
}
