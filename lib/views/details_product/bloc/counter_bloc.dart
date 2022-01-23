import 'dart:async';

enum CounterAction {
  Increment,
  Decrement,
}

class CounterDescriptionBloc {
  int counter;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;
  CounterDescriptionBloc() {
    counter = 1;
    eventStream.listen((event) {
      if (event == CounterAction.Decrement) {
        if (counter > 1) {
          counter--;
        }
      } else if (event == CounterAction.Increment) {
        counter++;
      }
      counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
