import 'dart:convert';

class SigninModel {
  final String username;
  final String password;
  final String name;

  SigninModel({this.username, this.password, this.name});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'name': name,
    };
  }

  factory SigninModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SigninModel(
      username: map['username'],
      password: map['password'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SigninModel.fromJson(String source) =>
      SigninModel.fromMap(json.decode(source));
}
