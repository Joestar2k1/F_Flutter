import 'dart:async';

import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/profile/widgets/body_pr.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _stateStreamController = StreamController<String>();
  StreamSink<String> get userSink => _stateStreamController.sink;
  Stream<String> get userStream => _stateStreamController.stream;
  @override
  void dispose() {
    super.dispose();

    _stateStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    userSink.add(RepositoryUser.info.username);
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<String>(
            initialData: RepositoryUser.info.username,
            stream: userStream,
            builder: (context, user) {
              return BodyProfile(
                username: user.data,
              );
            }),
      ),
    );
  }
}
