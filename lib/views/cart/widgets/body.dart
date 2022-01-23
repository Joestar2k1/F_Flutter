import 'package:fluter_19pmd/views/cart/widgets/bottom_nav.dart';
import 'package:fluter_19pmd/views/cart/widgets/item_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ItemCart(),
        Align(alignment: Alignment.bottomCenter, child: BottomNavBarCart()),
      ],
    );
  }
}
