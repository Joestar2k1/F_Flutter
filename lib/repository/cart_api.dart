import 'package:fluter_19pmd/models/invoice_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:http/http.dart' as http;

class RepositoryCart {
  static int number_cart = 0;

  static Future<List<Product>> getCart() async {
    var client = http.Client();
    List<Invoice> carts;
    List<Product> listProduct;
    final _quantityCartBloc = CartBloc();
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getCart/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      carts = invoiceFromJson(jsonString);
      carts.forEach((element) {
        listProduct = element.products;
      });
      (listProduct != null)
          ? number_cart = listProduct.length
          : number_cart = 0;
      print(number_cart);
      return listProduct;
    }
    return null;
  }

  static getQuantityCart() {}
  static Future<void> addToCart(String productID) async {
    var client = http.Client();
    var response = await client.post(
      Uri.parse(
        'http://10.0.2.2:8000/api/invoices/AddToCart/${RepositoryUser.info.id}',
      ),
      body: ({
        'productID': productID,
      }),
    );
    print(productID);
    print(response.body);
  }
}
