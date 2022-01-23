import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/views/details_product/widgets/body.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsProductScreen extends StatelessWidget {
  Product products;
  DetailsProductScreen({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(
          products: products,
        ),
      ),
    );
  }
}
