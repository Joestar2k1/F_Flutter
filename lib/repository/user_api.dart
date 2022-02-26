import 'dart:convert';

import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepositoryUser {
  static User info;
  static double getHeightAddress() {
    double dem = 0;
    for (var i = 0; i < info.address.length; i++) {
      dem += 50;
    }
    return dem;
  }

  static Future<User> fetchUserOnline() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/users/return-user/${info.id}'),
    );
    if (response.statusCode == 200) {
      var user = userFromJson(response.body);
      return user;
    } else {
      throw Exception("............................");
    }
  }

  static Future<dynamic> login(
      BuildContext context, String email, String password) async {
    var client = http.Client();
    var response =
        await client.post(Uri.parse('http://10.0.2.2:8000/api/users/login'),
            body: ({
              'email': email,
              'password': password,
            }));

    if (response.statusCode == 200) {
      info = userFromJson(response.body);

      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future<void> logout(context) async {
    var client = http.Client();
    var response =
        await client.get(Uri.parse('http://10.0.2.2:8000/api/users/logout'));
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 2));
      info = User();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
      );
    } else {}
  }

  static Future<dynamic> updateAccount(String username, String fullName,
      String email, String password, String phone) async {
    var client = http.Client();
    var response;
    if (password == '') {
      print(1);
      print(username + fullName + email + phone);
      response = await client.put(
          Uri.parse('http://10.0.2.2:8000/api/users/editUser/${info.id}'),
          body: ({
            'username': username,
            'fullName': fullName,
            'email': email,
            'phone': phone,
          }));
    } else {
      print(2);
      response = await client.put(
          Uri.parse('http://10.0.2.2:8000/api/users/editUser/${info.id}'),
          body: ({
            'username': username,
            'fullName': fullName,
            'email': email,
            'phone': phone,
            'password': password,
          }));
    }
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      info = userFromJson(response.body);
      return "Chỉnh sửa thành công";
    } else if (response.statusCode == 201) {
      return "Email đã tồn tại";
    } else {
      return "Chỉnh sửa thất bại";
    }
  }

  static Future register(String username, String fullName, String email,
      String password, String phone, String address) async {
    var client = http.Client();
    var response =
        await client.post(Uri.parse('http://10.0.2.2:8000/api/users/register'),
            body: ({
              'username': username,
              'fullName': fullName,
              'email': email,
              'phone': phone,
              'password': password,
              'address': address,
            }));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }
}
