import 'package:fluter_19pmd/models/product_models.dart';
import 'package:http/http.dart' as http;

class RepositoryProduct {
  static var getID;
  static List<Product> products = [];
  static double getHeight() {
    double dem = 0;
    for (var i = 1; i <= products.length; i++) {
      if (i % 2 != 0) {
        dem += 0.39;
      }
    }
    return dem;
  }

  static Future<List<Product>> getAllProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/products/getAllProduct'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      products = newProduct;
      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> viewDetails() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/products/details-product/${getID}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getFruitProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/products/showProductByTypeCategory/Trái cây'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getMeetProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/products/showProductByTypeCategory/Thịt'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getDrinkProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/products/showProductByTypeCategory/Thức uống'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getVegetableProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/products/showProductByTypeCategory/Rau củ'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> bestSeller() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/products/getBestSeller'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }
}
