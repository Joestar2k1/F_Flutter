import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/repository_products.dart';

enum ProductAciton {
  fetch,
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
      if (event == ProductAciton.fetch) {
        var products = await RepositoryProduct.getAllProduct();
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

  void dispose() {
    _stateStreamController.close();
  }
}
