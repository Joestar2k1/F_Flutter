import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/views/details_product/widgets/description_counter.dart';
import 'package:fluter_19pmd/views/details_product/widgets/user_review.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  const Body({Key key, this.details}) : super(key: key);
  final Product details;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DescriptionWidthCounter(
            description: details.description,
            stock: details.stock,
            price: details.price,
          ),
          UserReview(userReview: details.reviews),
        ],
      ),
    );
  }
}
