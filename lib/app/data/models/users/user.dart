class User {
  final String email;
  final String accessToken;
  final String firstName;
  final String lastName;

  User(this.email, this.accessToken, this.firstName, this.lastName);

  // User.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       email = json['email'];

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };
}
