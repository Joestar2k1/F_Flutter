import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/services/home/details_bloc.dart';
import 'package:fluter_19pmd/services/home/product_bloc.dart';
import 'package:fluter_19pmd/views/details_product/details_product.dart';
import 'package:fluter_19pmd/views/home/loadQuantityCart.dart';
import 'package:flutter/material.dart';

import '../../../function.dart';

// ignore: must_be_immutable
class ProductsHome extends StatefulWidget {
  const ProductsHome({
    Key key,
  }) : super(key: key);

  @override
  State<ProductsHome> createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {
  final productBloc = ProductBloc();
  final _viewDetails = ProductDetailsBloc();
  @override
  void initState() {
    productBloc.eventSink.add(EventProduct.fetch);
    super.initState();
  }

  @override
  void dispose() {
    productBloc.dispose();
    _viewDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        StreamBuilder<List<Product>>(
            initialData: [],
            stream: productBloc.productStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.error,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                );
              } else if (snapshot.hasData == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: size.height * RepositoryProduct.getHeight(),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _card(size, context, snapshot, index);
                      }),
                );
              }
            }),
      ],
    );
  }

  Widget _card(Size size, BuildContext context,
          AsyncSnapshot<List<Product>> snapshot, int index) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height * 0.37,
          width: size.width * 0.45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(
                width: 1.5,
                color: Colors.teal,
              )),
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  RepositoryProduct.getID = snapshot.data[index].id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsProductScreen(),
                    ),
                  );
                },
                child: contentCard(size, snapshot, index),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        RepositoryCart.addToCart(snapshot.data[index].id);
                      },
                      child: const Text(
                        "+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget contentCard(
      Size size, AsyncSnapshot<List<Product>> snapshot, int index) {
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.21,
          child: Image.asset(
              "assets/images/products/${snapshot.data[index].image}"),
        ),
        Text(
          snapshot.data[index].name,
          style: const TextStyle(
            fontSize: 25,
            color: Color(0xFF717171),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${convertToVND(snapshot.data[index].price)}đ",
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF717171),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: "\\",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF717171),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " ${snapshot.data[index].unit}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF717171),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
