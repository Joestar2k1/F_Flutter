import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/checkout/widgets/address.dart';
import 'package:fluter_19pmd/views/checkout/widgets/my-order.dart';
import 'package:fluter_19pmd/views/checkout/widgets/total_price_product.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Column(
      children: const [
        AddressInPayment(),
        MyOrder(),
        TotalPriceProduct(),
      ],
    );
  }
}
