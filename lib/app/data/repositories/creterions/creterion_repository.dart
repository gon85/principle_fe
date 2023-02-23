import 'dart:io';

import 'package:principle_fe/app/data/models/creterions/user_creterions_info.dart';
import 'package:principle_fe/app/data/models/errors/error_response.dart';
import 'package:principle_fe/app/data/models/errors/response_exception.dart';
import 'package:principle_fe/app/data/providers/rest_api.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class CreterionRepository {
  RestApi restApi;

  CreterionRepository({required this.restApi});

  Future<UserCreterionsInfo> getUserCreterionsInfo() async {
    logger.i('----> getUserCreterionsInfo!!!');
    final rep = await restApi.getUserCreterionInfo();

    if (rep.statusCode == HttpStatus.ok) {
      UserCreterionsInfo uci = UserCreterionsInfo.fromJson(rep.body);
      return uci;
    } else {
      ErrorResponse er = ErrorResponse.fromJson(rep.statusCode!, rep.body);
      throw ResponseException(er);
    }
  }
}
