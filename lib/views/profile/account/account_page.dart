import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/body.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: buttonColor,
            ),
          ),
          title: const Text(
            "Thiết lập tài khoản",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: const Body(),
      ),
    );
  }
}
