import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/filter/filter_screen.dart';
import 'package:fluter_19pmd/views/home/loadQuantityCart.dart';
import 'package:fluter_19pmd/views/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchWithIcons extends StatelessWidget {
  const SearchWithIcons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buttonSearch(size, context),
          buildIcon(
            size: size,
            img: "assets/icons/filter.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterPage(),
                ),
              );
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
                  padding: const EdgeInsets.all(15),
                  width: size.width * 0.12,
                  height: size.height * 0.08,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/shopping_bag.svg",
                    fit: BoxFit.cover,
                    color: textColor,
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
            children: const [
              Icon(
                Icons.search,
                color: Colors.teal,
              ),
              Text(
                "Tìm kiếm",
                style: TextStyle(
                  fontSize: 22,
                  color: textColor,
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
