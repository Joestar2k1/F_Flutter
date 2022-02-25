// To parse this JSON data, do
//
//     final invoices = invoicesFromJson(jsonString);

import 'dart:convert';

import 'package:fluter_19pmd/models/product_models.dart';

InvoiceDetails invoicesFromJson(String str) =>
    InvoiceDetails.fromJson(json.decode(str));

String invoicesToJson(InvoiceDetails data) => json.encode(data.toJson());

class InvoiceDetails {
  InvoiceDetails({
    this.id,
    this.userId,
    this.employeeId,
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
  String userId;
  String employeeId;
  String shippingName;
  String shippingAddress;
  String shippingPhone;
  int total;
  String dateCreated;
  int isPaid;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  List<Product> products;

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) => InvoiceDetails(
        id: json["id"],
        userId: json["userID"],
        employeeId: json["employeeID"],
        shippingName: json["shippingName"],
        shippingAddress: json["shippingAddress"],
        shippingPhone: json["shippingPhone"],
        total: json["total"],
        dateCreated: json["dateCreated"],
        isPaid: json["isPaid"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "employeeID": employeeId,
        "shippingName": shippingName,
        "shippingAddress": shippingAddress,
        "shippingPhone": shippingPhone,
        "total": total,
        "dateCreated": dateCreated,
        "isPaid": isPaid,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
