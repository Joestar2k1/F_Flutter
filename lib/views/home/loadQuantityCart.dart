import 'dart:async';

class LoadQuantityCart {
  //load-quantity-cart
  final _cartQuantity = StreamController<int>();
  StreamSink<int> get cartQuantitySink => _cartQuantity.sink;
  Stream<int> get cartQuantityStream => _cartQuantity.stream;
  void dispose() {
    _cartQuantity.close();
  }
}
