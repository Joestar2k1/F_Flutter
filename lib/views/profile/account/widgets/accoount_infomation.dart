import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';

class AccountInfomation extends StatelessWidget {
  AccountInfomation({Key key}) : super(key: key);
  final List infoAccount = [
    'Tên đăng nhập',
    'Email',
    'Họ tên',
    'Số điện thoại',
    'Ảnh'
  ];
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
                  ),
                  const SizedBox(height: 30),
                  buildInfo(infoPrimary: "Tên đăng nhập", infoSecond: "Email"),
                  const SizedBox(height: 20),
                  buildInfo(infoPrimary: "Họ tên", infoSecond: "Số điện thoại"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Ảnh",
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildInfo({String infoPrimary, String infoSecond}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoPrimary,
            style: const TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
          Text(
            infoSecond,
            style: const TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      );
}
