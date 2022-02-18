import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/profile/account/account_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_event.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final _profileBloc = ProfileInfoAccountBloc();

  final _username = TextEditingController();

  final _email = TextEditingController();

  final _fullName = TextEditingController();

  final _phone = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _profileBloc.dispose();
  }

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
              child: StreamBuilder<bool>(
                  initialData: false,
                  stream: _profileBloc.editProfileStream,
                  builder: (context, snapshot) {
                    if (!snapshot.data) {
                      return Column(
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
                          _buildTitle(),
                        ],
                      );
                    } else {
                      return Column(
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
                                      "Lưu",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: buttonColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.save,
                                      color: buttonColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          _buildTextForm(_username, _email, _fullName, _phone),
                        ],
                      );
                    }
                  }),
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
        _buildText('Tên hiển thị:', RepositoryUser.info.username),
        const SizedBox(height: 20),
        _buildText('Email:', RepositoryUser.info.email),
        const SizedBox(height: 20),
        _buildText('Họ tên:', RepositoryUser.info.fullName),
        const SizedBox(height: 20),
        _buildText('Số điện thoại:', RepositoryUser.info.phone),
      ],
    );
  }

  Widget _buildText(title, text) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.redAccent,
            ),
          ),
        ],
      );
  Widget _buildTextForm(
    TextEditingController us,
    TextEditingController email,
    TextEditingController fullName,
    TextEditingController phone,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _input(us, 'Tên hiển thị', RepositoryUser.info.username),
          _input(email, 'Email', RepositoryUser.info.username),
          _input(fullName, 'Họ tên', RepositoryUser.info.username),
          _input(phone, 'Số điện thoại', RepositoryUser.info.username),
        ],
      ),
    );
  }

  Widget _input(controller, title, value) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {},
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 18),
            labelText: title,
            labelStyle: const TextStyle(fontSize: 20),
          ),
        ),
      );
}
