import 'package:fluter_19pmd/models/user_models.dart';
import 'package:http/http.dart' as http;

class RepositoryUser {
  static Future<void> login(String email, String password) async {
    var client = http.Client();
    List<User> user;
    var response =
        await client.post(Uri.parse('http://10.0.2.2:8000/api/users/login'),
            body: ({
              'email': email,
              'password': password,
            }));
    if (response.statusCode == 200) {
      var user = userFromJson(response.body);
      print(user);
      // print(response.body);
    } else {}
  }
}
