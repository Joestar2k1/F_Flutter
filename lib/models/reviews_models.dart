// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

ProductDetails detailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String detailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
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
    this.reviews,
  });

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
  List<Review> reviews;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Review {
  Review({
    this.id,
    this.userId,
    this.productId,
    this.content,
    this.quantity,
    this.postedDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.avatar,
  });

  int id;
  String userId;
  String productId;
  String content;
  int quantity;
  DateTime postedDate;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  String fullName;
  String avatar;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userID"],
        productId: json["productID"],
        content: json["content"],
        quantity: json["quantity"],
        postedDate: DateTime.parse(json["postedDate"]),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fullName: json["fullName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "productID": productId,
        "content": content,
        "quantity": quantity,
        "postedDate": postedDate.toIso8601String(),
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "fullName": fullName,
        "avatar": avatar,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
