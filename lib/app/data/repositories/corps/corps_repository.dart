import 'dart:io';

import 'package:principle_fe/app/data/models/corps/corparation.dart';
import 'package:principle_fe/app/data/models/errors/error_response.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';

class CorpsRepository {
  RestApi restApi;

  CorpsRepository({required this.restApi});

  Future<List<Corparation>> getCorparationInfos() async {
    final rep = await restApi.getCorpses();

    if (rep.statusCode == HttpStatus.ok) {
      final list =
          (rep.body as List).map((e) => Corparation.fromJson(e)).toList();
      return list;
    } else {
      ErrorResponse er = ErrorResponse.fromJson(rep.statusCode!, rep.body);
      throw ResponseException(er);
    }
  }
}
