import 'dart:convert';

import 'package:fluter_19pmd/models/product_models.dart';

List<Invoice> invoiceFromJson(String str) =>
    List<Invoice>.from(json.decode(str).map((x) => Invoice.fromJson(x)));

String invoiceToJson(List<Invoice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
  Invoice({
    this.id,
    this.shippingName,
    this.shippingAddress,
    this.shippingPhone,
    this.total,
    this.dateCreated,
    this.isPaid,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  String id;
  String shippingName;
  String shippingAddress;
  String shippingPhone;
  int total;
  DateTime dateCreated;
  int isPaid;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  List<Product> products;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        shippingName: json["shippingName"],
        shippingAddress: json["shippingAddress"],
        shippingPhone: json["shippingPhone"],
        total: json["total"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        isPaid: json["isPaid"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shippingName": shippingName,
        "shippingAddress": shippingAddress,
        "shippingPhone": shippingPhone,
        "total": total,
        "dateCreated": dateCreated.toIso8601String(),
        "isPaid": isPaid,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
