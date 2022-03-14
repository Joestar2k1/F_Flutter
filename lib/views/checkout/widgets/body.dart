import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/views/checkout/widgets/address.dart';
import 'package:fluter_19pmd/views/checkout/widgets/my-order.dart';
import 'package:fluter_19pmd/views/checkout/widgets/total_price_product.dart';
import 'package:fluter_19pmd/views/checkout/widgets/vouchers.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _cartBloc = CartBloc();
  @override
  void initState() {
    _cartBloc.eventSink.add(CartEvent.fetchCart);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cartBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Cart>>(
        initialData: null,
        stream: _cartBloc.cartStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const AddressInPayment(),
                  MyOrder(carts: snapshot.data),
                  TotalPriceProduct(quantity: snapshot.data[0].quantity),
                  const VoucherList(),
                ],
              ),
            );
          } else {
            return Column(
              children: const [
                SizedBox(height: 300),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
        });
  }
}
