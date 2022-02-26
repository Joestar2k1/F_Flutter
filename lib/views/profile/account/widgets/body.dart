import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/account_information.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _profileBloc = ProfileBloc();
  @override
  void initState() {
    super.initState();
    _profileBloc.eventSink.add(UserEvent.fetch);
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('widget-account');
    return StreamBuilder<User>(
        initialData: null,
        stream: _profileBloc.userOnlineStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(height: 340),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AccountInformation(user: snapshot.data),
                  const SizedBox(height: 30),
                  buildCardAddress(context, snapshot.data.address),
                ],
              ),
            );
          }
        });
  }

  Widget buildCardAddress(context, address) => Card(
        shadowColor: Colors.teal,
        elevation: 10,
        margin: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderAddress(),
              const SizedBox(height: 30),
              buildListAddress(context, address),
            ],
          ),
        ),
      );

  Widget buildHeaderAddress() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Danh sách địa chỉ",
            style: TextStyle(
              fontSize: 24,
              color: buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Text(
                  "Sửa",
                  style: TextStyle(
                    fontSize: 24,
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.mode_edit_outline_outlined,
                  color: buttonColor,
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildListAddress(context, list) => SizedBox(
        height: RepositoryUser.getHeightAddress(),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '+${list[index].name}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: textColor,
                  ),
                ),
              ],
            );
          },
        ),
      );
}
