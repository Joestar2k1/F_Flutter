import 'dart:async';

import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';

enum UserEvent {
  fetch,
}

class ProfileBloc {
  final _stateStreamController = StreamController<User>();
  StreamSink<User> get _userOnlineSink => _stateStreamController.sink;
  Stream<User> get userOnlineStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<UserEvent>();
  StreamSink<UserEvent> get eventSink => _eventStreamController.sink;
  Stream<UserEvent> get _eventStream => _eventStreamController.stream;

  ProfileBloc() {
    _eventStream.listen((event) async {
      if (event == UserEvent.fetch) {
        var user = await RepositoryUser.fetchUserOnline();
        _userOnlineSink.add(user);
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
  }
}
