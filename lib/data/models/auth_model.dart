class LoginResponse {
  final String? token;

  LoginResponse({
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
    );
  }
}

class UserModule {
  final int? id;
  final String? name;

  UserModule({
    this.id,
    this.name,
  });

  factory UserModule.fromJson(Map<String, dynamic> json) {
    return UserModule(
      id: json['id'],
      name: json['name'],
    );
  }
}
