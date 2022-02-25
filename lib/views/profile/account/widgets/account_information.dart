import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_event.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final _profileBloc = ProfileBloc();
  final _openEdit = OpenEditAccount();

  final _username = TextEditingController(text: RepositoryUser.info.username);

  final _email = TextEditingController(text: RepositoryUser.info.email);

  final _fullName = TextEditingController(text: RepositoryUser.info.fullName);

  final _phone = TextEditingController(text: RepositoryUser.info.phone);
  final _password = TextEditingController();
  @override
  void initState() {
    super.initState();
    _profileBloc.eventSink.add(UserEvent.fetch);
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.dispose();
    _openEdit.dispose();
    _email.dispose();
    _fullName.dispose();
    _phone.dispose();
    _password.dispose();
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
                  stream: _openEdit.editProfileStream,
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
                                onPressed: () => _openEdit.eventSink
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      RepositoryUser.updateAccount(
                                          _username.text,
                                          _fullName.text,
                                          _email.text,
                                          _password.text,
                                          _phone.text);

                                      _openEdit.eventSink
                                          .add(AccountEvent.saveAccount);
                                      // _userEvent.eventSink
                                      //     .add(AccountEvent.editAccount);
                                    },
                                    child: const Icon(
                                      Icons.save,
                                      color: buttonColor,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _openEdit.eventSink
                                          .add(AccountEvent.saveAccount);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          _buildTextForm(
                              _username, _email, _fullName, _phone, _password),
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
    return StreamBuilder<User>(
        initialData: User(),
        stream: null,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child:
                    _buildText('Tên hiển thị:', RepositoryUser.info.username),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildText('Email:', RepositoryUser.info.email),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildText('Họ tên:', RepositoryUser.info.fullName),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildText('Số điện thoại:', RepositoryUser.info.phone),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildText('Mật khẩu:', '***********'),
              ),
            ],
          );
        });
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
    TextEditingController password,
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
          _input(password, 'Mật khẩu', RepositoryUser.info.username),
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
