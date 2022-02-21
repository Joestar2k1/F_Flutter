import 'dart:convert';

import 'package:fluter_19pmd/models/invoice_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';

import 'package:http/http.dart' as http;

class RepositoryCart {
  static String getID;
  static List<Invoice> cartClient = [];
  static int getQuantity;
  static subTotalCart() => cartClient[0].products.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity),
      );

  static Future<List<Product>> getCart() async {
    var client = http.Client();
    List<Invoice> carts;
    List<Product> listProduct;
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getCart/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      carts = invoiceFromJson(jsonString);
      cartClient = carts;
      carts.forEach((element) {
        listProduct = element.products;
      });
      return listProduct;
    }
    return null;
  }

  static Future<void> addToCartDetails(String productID) async {
    var client = http.Client();
    var response;

    response = await client.post(
      Uri.parse(
        'http://10.0.2.2:8000/api/invoices/AddToCart/${RepositoryUser.info.id}',
      ),
      body: ({
        'productID': productID,
        'shippingName': RepositoryUser.info.fullName,
        'shippingPhone': RepositoryUser.info.phone,
        'quantity': getQuantity.toString(),
      }),
    );

    print(response.body);
  }

  static Future<void> addToCart(String productID) async {
    var client = http.Client();
    var response;

    response = await client.post(
      Uri.parse(
        'http://10.0.2.2:8000/api/invoices/AddToCart/${RepositoryUser.info.id}',
      ),
      body: ({
        'productID': productID,
        'shippingName': RepositoryUser.info.fullName,
        'shippingPhone': RepositoryUser.info.phone,
      }),
    );

    print(response.body);
  }

  static Future<void> deleteProductCart(String productID) async {
    var client = http.Client();
    var response = await client.delete(
      Uri.parse(
        'http://10.0.2.2:8000/api/invoices/DeleteProductCart/${RepositoryUser.info.id}',
      ),
      body: ({
        'productID': productID,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception("Xóa lỗi");
    }
  }

  static Future<void> updateQuantityDecrement() async {
    var client = http.Client();
    var response = await client.put(
      Uri.parse(
        'http://10.0.2.2:8000/api/invoices/UpdateQuantityDecrement/${RepositoryUser.info.id}',
      ),
      body: ({
        'productID': getID,
        'invoiceID': cartClient[0].id,
      }),
    );
    if (response.statusCode == 200) {
      print(json.encode(response.body));
    } else {
      throw Exception("update Cart lỗi");
    }
  }

  static Future<void> updateQuantityIncrement() async {
    var client = http.Client();
    var response = await client.put(
      Uri.parse(
        'http://10.0.2.2:8000/api/invoices/UpdateQuantityIncrement/${RepositoryUser.info.id}',
      ),
      body: ({
        'productID': getID,
        'invoiceID': cartClient[0].id,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception("update Cart lỗi");
    }
  }
}
