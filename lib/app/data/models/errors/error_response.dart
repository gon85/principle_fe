class ErrorResponse {
  final int httpCode;
  final String? result;
  final String code;
  final String message;
  final Map<String, dynamic>? data;

  const ErrorResponse({
    required this.httpCode,
    required this.code,
    required this.message,
    this.result,
    this.data,
  });

  factory ErrorResponse.fromJson(int httpCode, Map<String, dynamic> json) {
    return ErrorResponse(
      httpCode: httpCode,
      result: json['result'],
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}
