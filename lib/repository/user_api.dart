import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
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
      var user = await userFromJson(response.body);
      return user;
    } else {
      throw Exception("............................");
    }
  }

  static Future<void> login(
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else if (response.statusCode == 201) {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception("Không ổn mật khẩu hoặc email sai");
    } else {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception("Không ổn mật khẩu hoặc email sai");
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

  static Future<void> updateAccount(String username, String fullName,
      String email, String password, String phone) async {
    var client = http.Client();
    var response = await client.put(
        Uri.parse('http://10.0.2.2:8000/api/users/editUser/${info.id}'),
        body: ({
          'username': username,
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'password': password,
        }));
    if (response.statusCode == 200) {
      info = userFromJson(response.body);
    } else if (response.statusCode == 201) {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception("Không ổn");
    } else {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception("Không ổn");
    }
  }
}
