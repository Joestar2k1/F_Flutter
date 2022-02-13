import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';

enum EventProduct {
  fetch,
  viewDetails,
}

class ProductBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _productSink => _stateStreamController.sink;
  Stream<List<Product>> get productStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<EventProduct>();
  StreamSink<EventProduct> get eventSink => _eventStreamController.sink;
  Stream<EventProduct> get _eventStream => _eventStreamController.stream;

  //details
  final _stateDetailsStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _detailsSink =>
      _stateDetailsStreamController.sink;
  Stream<List<Product>> get detailsStream =>
      _stateDetailsStreamController.stream;
  ProductBloc() {
    _eventStream.listen((event) async {
      if (event == EventProduct.fetch) {
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
      if (event == EventProduct.viewDetails) {
        var products = await RepositoryProduct.viewDetails();

        try {
          if (products != null) {
            _detailsSink.add(products);
          } else {
            _detailsSink.addError('get products don\'t completed');
          }
        } on Exception {
          _detailsSink.addError('get products don\'t completed');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _stateDetailsStreamController.close();
  }
}
