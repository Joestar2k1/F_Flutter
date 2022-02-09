import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/repository_products.dart';

enum ProductAciton {
  fetchAll,
  fetchFruit,
  fetchMeet,
  fetchDrink,
  fetchVegetable,
}

class CategoryBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _categorySink => _stateStreamController.sink;
  Stream<List<Product>> get categoryStream => _stateStreamController.stream;
  final _eventStreamController = StreamController<ProductAciton>();
  StreamSink<ProductAciton> get eventSink => _eventStreamController.sink;
  Stream<ProductAciton> get _eventStream => _eventStreamController.stream;

  CategoryBloc() {
    _eventStream.listen((event) async {
      if (event == ProductAciton.fetchAll) {
        var products = await RepositoryProduct.getAllProduct();
        try {
          if (products != null) {
            _categorySink.add(products);
          } else {
            _categorySink.addError('get All don\'t completed');
          }
        } on Exception {
          _categorySink.addError('get All don\'t completed');
        }
      } else if (event == ProductAciton.fetchFruit) {
        var products = await RepositoryProduct.getFruitProduct();
        try {
          if (products != null) {
            _categorySink.add(products);
          } else {
            _categorySink.addError('get fruit don\'t completed');
          }
        } on Exception {
          _categorySink.addError('get fruit don\'t completed1');
        }
      } else if (event == ProductAciton.fetchMeet) {
        var products = await RepositoryProduct.getMeetProduct();
        try {
          if (products != null) {
            _categorySink.add(products);
          } else {
            _categorySink.addError('get meet don\'t completed');
          }
        } on Exception {
          _categorySink.addError('get meet don\'t completed1');
        }
      } else if (event == ProductAciton.fetchDrink) {
        var products = await RepositoryProduct.getDrinkProduct();
        try {
          if (products != null) {
            _categorySink.add(products);
          } else {
            _categorySink.addError('get drink don\'t completed');
          }
        } on Exception {
          _categorySink.addError('get drink don\'t completed1');
        }
      } else if (event == ProductAciton.fetchVegetable) {
        var products = await RepositoryProduct.getVegetableProduct();
        try {
          if (products != null) {
            _categorySink.add(products);
          } else {
            _categorySink.addError('get vegetable don\'t completed');
          }
        } on Exception {
          _categorySink.addError('get vegetable don\'t completed1');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
