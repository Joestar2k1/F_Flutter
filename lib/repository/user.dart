import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:fluter_19pmd/views/login/sigin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepositoryUser {
  static User info;
  static void _getFromUserServe(User users) {
    info = User(
        id: users.id,
        username: users.username,
        fullName: users.fullName,
        email: users.email,
        password: users.password,
        phone: users.phone,
        avatar: users.avatar,
        status: users.status);
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      var user = userFromJson(response.body);
      _getFromUserServe(user[0]);
      await Future.delayed(const Duration(seconds: 2));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else if (response.statusCode == 201) {
      await Future.delayed(const Duration(seconds: 2));
      throw Exception("Không ổn mật khẩu hoặc email sai");
    } else {
      await Future.delayed(const Duration(seconds: 2));
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
}
