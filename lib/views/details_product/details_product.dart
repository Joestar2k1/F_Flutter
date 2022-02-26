import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/home/details_bloc.dart';
import 'package:fluter_19pmd/services/home/product_bloc.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/details_product/widgets/body.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({Key key}) : super(key: key);

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
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
    return SafeArea(
      child: StreamBuilder<ProductDetails>(
          initialData: null,
          stream: _viewDetails.detailsStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Column(
                  children: [
                    SizedBox(height: size.height * 0.45),
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Scaffold(
              body: Body(details: snapshot.data),
              bottomNavigationBar: _buildBottomNav(size, context),
            );
          }),
    );
  }

  Widget _buildBottomNav(size, context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 0),
            color: Colors.grey,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.5,
            height: size.height * 0.08,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttonColor,
                ),
              ),
              onPressed: () async {
                await RepositoryCart.addToCartDetails(RepositoryProduct.getID);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.card_travel),
                  Text(
                    "Thêm giỏ hàng",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
