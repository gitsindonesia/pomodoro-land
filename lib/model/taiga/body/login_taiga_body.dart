import 'dart:convert';

class LoginTaigaBody {
  const LoginTaigaBody({
    required this.username,
    required this.password,
    required this.type,
  });

  final String username;
  final String password;
  final String type;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'type': type,
    };
  }

  factory LoginTaigaBody.fromMap(Map<String, dynamic> map) {
    return LoginTaigaBody(
      username: map['username'],
      password: map['password'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginTaigaBody.fromJson(String source) =>
      LoginTaigaBody.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginTaigaBody &&
        other.username == username &&
        other.password == password &&
        other.type == type;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ type.hashCode;
}
