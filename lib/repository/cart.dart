import 'package:fluter_19pmd/models/invoice_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/user.dart';
import 'package:http/http.dart' as http;

class RepositoryCart {
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
      carts.forEach((element) {
        listProduct = element.products;
      });
      return listProduct;
    }
    return null;
  }
}
