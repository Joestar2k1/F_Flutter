import 'package:fluter_19pmd/models/invoice_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/user.dart';
import 'package:http/http.dart' as http;

class RepositoryInvoice {
  static List<Invoice> invoices;
  static Future<List<Product>> getInvoiceSuccess() async {
    var client = http.Client();

    List<Product> listProduct = [];
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getInvoiceSuccess/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoiceFromJson(jsonString);
      invoices.forEach((data) {
        data.products.forEach((element) {
          listProduct.add(element);
        });
      });
      return listProduct;
    }
    return null;
  }
}
