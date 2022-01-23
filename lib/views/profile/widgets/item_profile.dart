import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/profile/account/account_page.dart';
import 'package:fluter_19pmd/views/profile/order/order_page.dart';
import 'package:flutter/material.dart';

class ItemProfile extends StatelessWidget {
  int index;
  var profiles;
  ItemProfile({
    Key key,
    this.profiles,
    this.index,
  }) : super(key: key);

  final pages = [
    const AccountPage(),
    const OrderPage(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pages[index],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal.shade200],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(profiles[index]['icon']),
                  Text(
                    profiles[index]['text'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
