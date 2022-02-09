import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/views/details_product/widgets/description_counter.dart';
import 'package:fluter_19pmd/views/details_product/widgets/img_price_product.dart';
import 'package:fluter_19pmd/views/details_product/widgets/user_review.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({Key key, this.products}) : super(key: key);
  Product products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImgWidthPrice(),
          const DescriptionWidthCounter(),
          const UserReview(),
        ],
      ),
    );
  }
}
