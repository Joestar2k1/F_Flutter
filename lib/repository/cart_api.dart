import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';

import 'package:http/http.dart' as http;

class RepositoryCart {
  static String getID;
  static List<Invoices> cartClient = [];
  static int getQuantity;
  static subTotalCart() {
    if (cartClient.isEmpty) {
      return 0;
    }
    return cartClient[0].products.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.price * element.quantity),
        );
  }

  static Future<List<Cart>> getCart() async {
    var client = http.Client();
    List<Invoices> carts;
    List<Cart> listProduct;
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getCart/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      carts = invoicesFromJson(jsonString);
      cartClient = carts;
      carts.forEach((element) {
        listProduct = element.products;
      });
      return listProduct;
    }
    return null;
  }

  static Future<dynamic> addToCartDetails(String productID) async {
    var client = http.Client();
    var response = await client.post(
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

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 201;
    }
  }

  static Future<dynamic> addToCart(String productID) async {
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
    if (response.statusCode == 200) {
      return "Thêm thành công";
    } else {
      return "Thêm thất bại";
    }
  }

  static Future<dynamic> deleteProductCart(String productID) async {
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
      cartClient = [];
      return "Xóa sản phẩm thành công";
    } else {
      return "Xóa sản phẩm thành công";
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
    } else {
      throw Exception("update Cart lỗi");
    }
  }
}
