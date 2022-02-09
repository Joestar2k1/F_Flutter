import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';

class DetailsBloc {
  final _streamStateController = StreamController<Product>();
  StreamSink<Product> get detailsSink => _streamStateController.sink;
  Stream get detailsStream => _streamStateController.stream;

  void dispose() {
    _streamStateController.close();
  }
}
