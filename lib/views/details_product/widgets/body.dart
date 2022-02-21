import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/services/home/details_bloc.dart';
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
  final _viewDetails = ProductDetailsBloc();

  @override
  void initState() {
    super.initState();
    _viewDetails.eventSink.add(EventProduct.viewDetails);
  }

  @override
  void dispose() {
    _viewDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: StreamBuilder<ProductDetails>(
          initialData: ProductDetails(),
          stream: _viewDetails.detailsStream,
          builder: (context, snapshot) {
            return Column(
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
                                  (snapshot.data.name != null)
                                      ? snapshot.data.name
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: "RobotoSlab",
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  (snapshot.data.price != null)
                                      ? '${convertToVND(snapshot.data.price)}đ/${snapshot.data.unit}'
                                      : "",
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
                            child: (snapshot.data.image != null)
                                ? Image.asset(
                                    "assets/images/products/${snapshot.data.image}",
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.teal,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const AppBarDetails(),
                    ],
                  ),
                ),
                DescriptionWidthCounter(
                  description: snapshot.data.description,
                  stock: snapshot.data.stock,
                ),
                UserReview(userReview: snapshot.data.reviews),
              ],
            );
          }),
    );
  }
}
