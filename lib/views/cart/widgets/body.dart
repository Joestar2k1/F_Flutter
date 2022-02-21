import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/views/cart/counter_cart_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _counterBloc = CounterBloc();
  final _cartBloc = CartBloc();
  @override
  void initState() {
    _cartBloc.eventSink.add(CartEvent.fetchCart);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _counterBloc.dispose();
    _cartBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<Product>>(
            initialData: [],
            stream: _cartBloc.cartStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _card(snapshot, context, size);
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/icons-png/shopping_cart.png",
                            width: 30,
                            height: 30,
                          ),
                          const Text(
                            "Bạn chưa có sản phẩm trong giỏ hàng",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ],
    );
  }

  Widget _card(snapshot, context, size) => Expanded(
          child: ListView.separated(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(15.0),
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: InkWell(
                      onTap: () {
                        RepositoryCart.deleteProductCart(
                            snapshot.data[index].id);
                        _cartBloc.eventSink.add(CartEvent.fetchCart);
                      },
                      child: Image.asset("assets/images/icons-png/trash.png")),
                ),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.teal.shade200],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Image.asset(
                      "assets/images/products/${snapshot.data[index].image}"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data[index].name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildItemInfo(
                        text: "Giá: ", number: snapshot.data[index].price),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildItemInfo(
                        text: "Tồn kho: ", number: snapshot.data[index].stock),
                    const SizedBox(
                      height: 10,
                    ),
                    _counter(
                        size: size,
                        quantity: snapshot.data[index].quantity,
                        productID: snapshot.data[index].id,
                        stock: snapshot.data[index].stock),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ));

  Widget _buildItemInfo({String text, int number}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "${convertToVND(number)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );

  Widget _counter({Size size, int quantity, String productID, int stock}) =>
      SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      RepositoryCart.getID = productID;
                      _counterBloc.eventSink.add(CounterEvent.decrement);
                      _cartBloc.eventSink.add(CartEvent.fetchCart);
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
            ),
            Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  if (quantity < stock) {
                    RepositoryCart.getID = productID;
                    _counterBloc.eventSink.add(CounterEvent.increment);
                    _cartBloc.eventSink.add(CartEvent.fetchCart);
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
}
