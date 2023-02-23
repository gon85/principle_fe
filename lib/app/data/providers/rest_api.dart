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
}
