import 'package:fluter_19pmd/views/home/widgets/banner.dart';
import 'package:fluter_19pmd/views/home/widgets/categories.dart';
import 'package:fluter_19pmd/views/home/widgets/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var textSearch = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerHome(),
                const SizedBox(height: 30),
                Categories(),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Bán chạy",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF717171),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                loadBestSeller(size: size),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Sản phẩm",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF717171),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const ProductsHome(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadBestSeller({Size size}) => SizedBox(
        height: size.height * 0.35,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) => Card(
            shadowColor: Colors.teal,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Rau củ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFF34848),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: Image.asset(
                          'assets/images/icons-png/best_seller.png',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: Image.asset('assets/images/products/7.png'),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Rau salad",
                            style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFF717171),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "\$2",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF717171),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Xem ngay',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
