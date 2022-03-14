import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/views/details_product/widgets/app_bar.dart';
import 'package:fluter_19pmd/views/details_product/widgets/description_counter.dart';
import 'package:fluter_19pmd/views/details_product/widgets/user_review.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  const Body({Key key, this.details}) : super(key: key);
  final Product details;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.4,
            width: size.width,
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
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: "RobotoSlab",
                                color: Colors.grey.shade800),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '${convertToVND(details.price)}đ/${details.unit}',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "RobotoSlab",
                                color: Colors.grey.shade800),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Image.network(
                      details.image,
                      fit: BoxFit.cover,
                    )),
                  ],
                ),
                AppBarDetails(
                  checkFavorite: details.checkFavorite,
                ),
              ],
            ),
          ),
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
