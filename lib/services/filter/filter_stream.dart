import 'dart:async';

class FilterBloc {
  final _stateStreamController = StreamController<String>();
  StreamSink<String> get typeSink => _stateStreamController.sink;
  Stream<String> get typeStream => _stateStreamController.stream;

  final _stateSearchStreamController = StreamController<int>();
  StreamSink<int> get priceSink => _stateSearchStreamController.sink;
  Stream<int> get priceStream => _stateSearchStreamController.stream;

  void dispose() {
    _stateStreamController.close();
    _stateSearchStreamController.close();
  }
}
