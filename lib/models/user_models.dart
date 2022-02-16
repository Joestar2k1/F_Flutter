import 'dart:convert';

import 'package:fluter_19pmd/repository/user.dart';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.password,
    this.phone,
    this.avatar,
    this.status,
    this.emailVerifiedAt,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String username;
  String fullName;
  String email;
  String password;
  String phone;
  String avatar;
  int status;
  dynamic emailVerifiedAt;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        avatar: json["avatar"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullName": fullName,
        "email": email,
        "password": password,
        "phone": phone,
        "avatar": avatar,
        "status": status,
        "email_verified_at": emailVerifiedAt,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
