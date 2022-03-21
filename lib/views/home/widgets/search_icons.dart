import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchWithIcons extends StatelessWidget {
  const SearchWithIcons({Key key, this.context}) : super(key: key);
  final BuildContext context;
  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buttonSearch(size, context),
          // buildIcon(
          //   size: size,
          //   img: "assets/icons/filter.svg",
          //   press: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          // ),
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
  }

  Widget _buttonSearch(size, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width * 0.65,
          height: size.height * 0.06,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey.shade600,
              ),
              Text(
                "Tìm kiếm",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600,
                ),
              )
            ],
          ),
        ),
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
