import 'package:fluter_19pmd/services/home/product_bloc.dart';
import 'package:fluter_19pmd/views/details_product/widgets/app_bar.dart';
import 'package:fluter_19pmd/views/details_product/widgets/description_counter.dart';
import 'package:fluter_19pmd/views/details_product/widgets/user_review.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _detailsBloc = ProductBloc();

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
                            'Dâu tằm'.toString(),
                            style: const TextStyle(
                                fontSize: 30,
                                fontFamily: "RobotoSlab",
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            25000.toString(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontFamily: "RobotoSlab",
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/images/products/1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const AppBarDetails(),
              ],
            ),
          ),
          const DescriptionWidthCounter(),
          const UserReview(),
        ],
      ),
    );
  }
}
