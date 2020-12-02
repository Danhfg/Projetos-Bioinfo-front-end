import 'dart:convert';

class SigninModel {
  final String username;
  final String password;

  SigninModel({this.username, this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory SigninModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SigninModel(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SigninModel.fromJson(String source) =>
      SigninModel.fromMap(json.decode(source));
}
