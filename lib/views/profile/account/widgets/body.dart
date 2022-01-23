import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/item_account.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              "Tài khoản",
              style: TextStyle(color: textColor, fontSize: 20),
            ),
          ),
          ItemAccount(),
        ],
      ),
    );
  }
}
