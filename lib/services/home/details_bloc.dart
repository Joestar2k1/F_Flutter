import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/home/product_bloc.dart';

class ProductDetailsBloc {
  final _eventStreamController = StreamController<EventProduct>();
  StreamSink<EventProduct> get eventSink => _eventStreamController.sink;
  Stream<EventProduct> get _eventStream => _eventStreamController.stream;

  //details
  final _stateDetailsStreamController = StreamController<ProductDetails>();
  StreamSink<ProductDetails> get _detailsSink =>
      _stateDetailsStreamController.sink;
  Stream<ProductDetails> get detailsStream =>
      _stateDetailsStreamController.stream;
  ProductDetailsBloc() {
    _eventStream.listen((event) async {
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
    _stateDetailsStreamController.close();
  }
}
