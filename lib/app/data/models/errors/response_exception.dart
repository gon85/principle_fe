import 'package:principle_fe/app/data/models/errors/error_response.dart';

class ResponseException implements Exception {
  late final String message;
  late final ErrorResponse errorResponse;

  ResponseException(this.errorResponse) {
    message = errorResponse.message;
  }

  @override
  String toString() {
    return "Exception: ${errorResponse.message}";
  }
}
