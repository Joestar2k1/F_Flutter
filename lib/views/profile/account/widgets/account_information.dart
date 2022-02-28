import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_event.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key key, this.user}) : super(key: key);
  final User user;
  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final _openEdit = OpenEditAccount();

  final _username = TextEditingController();

  final _email = TextEditingController();

  final _fullName = TextEditingController();

  final _phone = TextEditingController();

  final _password = TextEditingController();
  final _profileBloc = ProfileBloc();
  @override
  void initState() {
    _username.text = widget.user.username;
    _email.text = widget.user.email;
    _fullName.text = widget.user.fullName;
    _phone.text = widget.user.phone;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _openEdit.dispose();
    _username.dispose();
    _email.dispose();
    _fullName.dispose();
    _phone.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        initialData: widget.user,
        stream: _profileBloc.userOnlineStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amberAccent));
          }
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
                        builder: (context, value) {
                          if (!value.data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      child: const Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                                _buildTitle(user: snapshot.data),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          onPressed: () async {
                                            var messageFormSever =
                                                await RepositoryUser
                                                    .updateAccount(
                                                        _username.text,
                                                        _fullName.text,
                                                        _email.text,
                                                        _password.text,
                                                        _phone.text);
                                            _showMyDialog(
                                                messageFormSever, context);
                                            _profileBloc.eventSink
                                                .add(UserEvent.fetch);
                                            _openEdit.eventSink
                                                .add(AccountEvent.saveAccount);
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
                                _buildTextForm(_username, _email, _fullName,
                                    _phone, _password, snapshot.data),
                              ],
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _buildTitle({User user}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Tên hiển thị:', user.username),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Email:",
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 270,
                height: 30,
                child: Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.redAccent,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Họ tên:', user.fullName),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Số điện thoại:', user.phone),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Mật khẩu:', '***********'),
        ),
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
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ],
      );
  Widget _buildTextForm(
    us,
    email,
    fullName,
    phone,
    password,
    data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _input(us, 'Tên hiển thị'),
        _input(email, 'Email'),
        _input(fullName, 'Họ tên'),
        _input(phone, 'Số điện thoại'),
        _input(password, 'Mật khẩu'),
      ],
    );
  }

  Widget _input(controller, title) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 18),
            labelText: title,
            labelStyle: const TextStyle(fontSize: 20),
          ),
        ),
      );

  Future<void> _showMyDialog(message, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/icons-png/error.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          content: Center(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.teal,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                (message.contains('thất bại')) ? 'Thử lại' : 'Oke',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}
