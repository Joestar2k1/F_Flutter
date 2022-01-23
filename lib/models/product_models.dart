// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) {
  return List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
}

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String id;
  String name;
  int price;
  int stock;
  String type;
  String unit;
  String description;
  String image;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  Product({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.type,
    this.unit,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        type: json["type"],
        unit: json["unit"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "type": type,
        "unit": unit,
        "description": description,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
