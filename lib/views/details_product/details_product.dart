import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/details_product/widgets/body.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({Key key, this.products}) : super(key: key);
  final Product products;
  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  final _isLoading = LoadingBloc();

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: (widget.products == null)
          ? Scaffold(
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
            )
          : Scaffold(
              backgroundColor: Colors.white,
              body: Body(details: widget.products),
              bottomNavigationBar: _buildBottomNav(size, context),
            ),
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
          StreamBuilder<bool>(
              initialData: false,
              stream: _isLoading.loadingStream,
              builder: (context, state) {
                return SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.08,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        buttonColor,
                      ),
                    ),
                    onPressed: () async {
                      _isLoading.loadingSink.add(true);

                      var data = await RepositoryCart.addToCartDetails(
                          RepositoryProduct.getID);
                      if (data == 200) {
                        _isLoading.loadingSink.add(false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ));
                      } else {}
                    },
                    child: (state.data)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.car_repair_sharp),
                              Text(
                                "Đang xử lý ...",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Row(
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
                );
              }),
        ],
      ),
    );
  }
}
