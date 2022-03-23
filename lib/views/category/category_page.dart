import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/category/export_category.dart';
import 'package:fluter_19pmd/views/filter/filter_screen.dart';
import 'package:fluter_19pmd/views/search/search_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          endDrawer: const FilterPage(),
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            bottom: buildTab(),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            title: const Text(
              "Danh mục",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            actions: [
              Builder(builder: (context) {
                return SizedBox(
                  width: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildIcon(
                        size: size,
                        img: "assets/icons/filter.svg",
                        press: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: size.width * 0.12,
                              height: size.height * 0.08,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.shopping_cart_rounded,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                            // Positioned(
                            //   top: 5,
                            //   right: -0,
                            //   child: Container(
                            //     width: 20,
                            //     height: 20,
                            //     decoration: const BoxDecoration(
                            //       color: Colors.red,
                            //       shape: BoxShape.circle,
                            //     ),
                            //     child: Center(
                            //         child: Text(
                            //       snapshot.data.toString(),
                            //       style: const TextStyle(
                            //         fontSize: 15,
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     )),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.teal.shade200],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: _item(),
          // body: Body(),
        ),
      ),
    );
  }

  Widget _item() => const TabBarView(
        dragStartBehavior: DragStartBehavior.down,
        children: [
          AllPage(),
          FruitPage(),
          MeetPage(),
          DrinkPage(),
          VegetablePage(),
        ],
      );
  Widget buildTab() => const TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        tabs: [
          Tab(
            child: Text(
              "Tất cả",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Trái cây",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Thịt",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Thức uống",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Rau củ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  InkWell buildIcon({Size size, String img, Function() press}) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: size.width * 0.12,
        height: size.height * 0.08,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          img,
          fit: BoxFit.cover,
          color: textColor,
        ),
      ),
    );
  }
}
