import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/catetogory/cate_bloc.dart';
import 'package:fluter_19pmd/views/details_product/details_product.dart';
import 'package:flutter/material.dart';

class VegetablePage extends StatefulWidget {
  const VegetablePage({Key key}) : super(key: key);

  @override
  _VegetablePageState createState() => _VegetablePageState();
}

class _VegetablePageState extends State<VegetablePage> {
  final cateBloc = CategoryBloc();

  @override
  void initState() {
    cateBloc.eventSink.add(CategoryEvent.fetchVegetable);
    super.initState();
  }

  @override
  void dispose() {
    cateBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Product>>(
              stream: cateBloc.categoryStream,
              initialData: [],
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
                } else if (snapshot.hasData == false) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
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
                                    RepositoryProduct.getID =
                                        snapshot.data[index].id;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailsProductScreen(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        height: size.height * 0.21,
                                        child: Hero(
                                          tag: snapshot.data[index].id,
                                          child: Image.asset(
                                              "assets/images/products/${snapshot.data[index].image}"),
                                        ),
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
                                              text:
                                                  "${convertToVND(snapshot.data[index].price)}đ",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF717171),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: " \\ ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF717171),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " ${snapshot.data[index].unit}",
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
                                  ),
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
                                          RepositoryCart.addToCart(
                                              snapshot.data[index].id);
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
                      });
                }
              }),
        ),
      ],
    );
  }
}
