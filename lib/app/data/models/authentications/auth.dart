class AuthModel {
  final String? email;
  final String accessToken;

  const AuthModel({required this.email, required this.accessToken});

  factory AuthModel.fromJson(Map<String, dynamic> json, [String? email]) {
    return AuthModel(
      email: json['email'] ?? email,
      accessToken: json['accessToken'],
    );
  }
}
