// To parse this JSON data, do
//
//     final favorites = favoritesFromJson(jsonString);

import 'dart:convert';

import 'package:fluter_19pmd/models/product_models.dart';

List<Favorites> favoritesFromJson(String str) =>
    List<Favorites>.from(json.decode(str).map((x) => Favorites.fromJson(x)));

String favoritesToJson(List<Favorites> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorites {
  Favorites({
    this.id,
    this.userId,
    this.title,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  String id;
  String userId;
  String title;
  String productId;
  dynamic createdAt;
  dynamic updatedAt;
  List<Product> products;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        id: json["id"],
        userId: json["userID"],
        title: json["title"],
        productId: json["productID"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "title": title,
        "productID": productId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
