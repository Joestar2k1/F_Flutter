import 'dart:convert';

import 'package:fluter_19pmd/models/favorites_model.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

class RepositoryFavorite {
  static getHeightItem(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 40;
    }
    return dem;
  }

  static getHeight(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 95;
    }
    return dem;
  }

  static getHeightForBody(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 0.14;
    }
    return dem;
  }

  static Future<List<Favorites>> showFavorite() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse(
        'http://10.0.2.2:8000/api/favorites/show/${RepositoryUser.info.id}',
      ),
    );
    if (response.statusCode == 200) {
      var favorites = favoritesFromJson(response.body);

      return favorites;
    } else {
      throw Exception("update Cart lỗi");
    }
  }

  static Future<dynamic> addTitle(String title) async {
    var client = http.Client();
    var response;

    response = await client.post(
      Uri.parse(
        'http://10.0.2.2:8000/api/favorites/AddFavoriteTitle/${RepositoryUser.info.id}',
      ),
      body: ({
        'userID': RepositoryUser.info.id,
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<dynamic> deleteFavorite(String id) async {
    var client = http.Client();
    var response;

    response = await client.delete(
      Uri.parse(
        'http://10.0.2.2:8000/api/favorites/DeleteFavoriteTitle',
      ),
      body: ({
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
