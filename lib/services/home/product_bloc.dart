import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:http/http.dart' as http;

enum ProductAciton {
  Fetch,
  ADD,
  Delete,
}

class ProductBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _productSink => _stateStreamController.sink;
  Stream<List<Product>> get productStream => _stateStreamController.stream;
  final _eventStreamController = StreamController<ProductAciton>();
  StreamSink<ProductAciton> get eventSink => _eventStreamController.sink;
  Stream<ProductAciton> get _eventStream => _eventStreamController.stream;

  ProductBloc() {
    _eventStream.listen((event) async {
      if (event == ProductAciton.Fetch) {
        var products = await getProduct();
        try {
          if (products != null) {
            _productSink.add(products);
          } else {
            _productSink.addError('get products don\'t completed');
          }
        } on Exception {
          _productSink.addError('get products don\'t completed');
        }
      }
    });
  }

  Future<List<Product>> getProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/products/getAllProduct'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  void dispose() {
    _stateStreamController.close();
  }
}
