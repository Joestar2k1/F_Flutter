import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/views/details_product/widgets/app_bar.dart';
import 'package:fluter_19pmd/views/details_product/widgets/description_counter.dart';
import 'package:fluter_19pmd/views/details_product/widgets/user_review.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  const Body({Key key, this.details}) : super(key: key);
  final ProductDetails details;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.4,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 130, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details.name,
                            style: const TextStyle(
                                fontSize: 30,
                                fontFamily: "RobotoSlab",
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '${convertToVND(details.price)}đ/${details.unit}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "RobotoSlab",
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Image.asset(
                      "assets/images/products/${details.image}",
                      fit: BoxFit.cover,
                    )),
                  ],
                ),
                const AppBarDetails(),
              ],
            ),
          ),
          DescriptionWidthCounter(
            description: details.description,
            stock: details.stock,
          ),
          UserReview(userReview: details.reviews),
        ],
      ),
    );
  }
}
