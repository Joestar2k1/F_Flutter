import 'dart:async';

import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';

enum UserEvent {
  fetch,
  fetchAddress,
}

class ProfileBloc {
  final _stateStreamController = StreamController<User>();
  StreamSink<User> get userOnlineSink => _stateStreamController.sink;
  Stream<User> get userOnlineStream => _stateStreamController.stream;
  //address
  final _stateAddressController = StreamController<List<Address>>();
  StreamSink<List<Address>> get _userAddressSink =>
      _stateAddressController.sink;
  Stream<List<Address>> get userAddressStream => _stateAddressController.stream;

  final _eventStreamController = StreamController<UserEvent>();
  StreamSink<UserEvent> get eventSink => _eventStreamController.sink;
  Stream<UserEvent> get _eventStream => _eventStreamController.stream;

  ProfileBloc() {
    _eventStream.listen((event) async {
      if (event == UserEvent.fetch) {
        var user = await RepositoryUser.fetchUserOnline();
        userOnlineSink.add(user);
      } else if (event == UserEvent.fetchAddress) {
        var user = await RepositoryUser.fetchUserOnline();
        _userAddressSink.add(user.address);
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _stateAddressController.close();
  }
}
