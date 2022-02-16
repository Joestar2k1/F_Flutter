import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/user.dart';
import 'package:fluter_19pmd/views/profile/account/account_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_event.dart';
import 'package:flutter/material.dart';

class AccountInfomation extends StatelessWidget {
  AccountInfomation({Key key}) : super(key: key);
  final _profileBloc = ProfileInfoAccountBloc();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _fullName = TextEditingController();
  final _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thông tin tài khoản",
                        style: TextStyle(
                          fontSize: 24,
                          color: buttonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _profileBloc.eventSink
                            .add(AccountEvent.editAccount),
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
                  ),
                  StreamBuilder<bool>(
                      stream: _profileBloc.editProfileStream,
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.data) {
                          return _buildTextForm(
                              _username, _email, _fullName, _phone);
                        } else {
                          return _buildTitle();
                        }
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Tên hiển thị:",
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
            Text(
              RepositoryUser.info.username,
              style: const TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Email",
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Họ tên",
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Số điện thoại",
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTextForm(TextEditingController us, TextEditingController email,
      TextEditingController fullName, TextEditingController phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: TextFormField(
            controller: us,
            style: const TextStyle(fontSize: 20),
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (value) {},
            decoration: const InputDecoration(
              errorStyle: TextStyle(fontSize: 18),
              labelText: "Enter Tên hiển thị",
              labelStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: TextFormField(
            controller: us,
            style: const TextStyle(fontSize: 20),
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (value) {},
            decoration: const InputDecoration(
              errorStyle: TextStyle(fontSize: 18),
              labelText: "Enter email",
              labelStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: TextFormField(
            controller: us,
            style: const TextStyle(fontSize: 20),
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (value) {},
            decoration: const InputDecoration(
              errorStyle: TextStyle(fontSize: 18),
              labelText: "Enter họ và tên",
              labelStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
