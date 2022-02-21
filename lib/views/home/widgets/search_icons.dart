import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/filter/filter_screen.dart';
import 'package:fluter_19pmd/views/home/loadQuantityCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchWithIcons extends StatefulWidget {
  const SearchWithIcons({
    Key key,
  }) : super(key: key);

  @override
  State<SearchWithIcons> createState() => _SearchWithIconsState();
}

class _SearchWithIconsState extends State<SearchWithIcons> {
  final _cart = CartBloc();
  final _quantityCartBloc = LoadQuantityCart();
  @override
  void initState() {
    _cart.eventSink.add(CartEvent.fetchCart);
    _quantityCartBloc.cartQuantitySink.add(RepositoryCart.cartClient.length);
    super.initState();
  }

  @override
  void dispose() {
    _cart.dispose();
    _quantityCartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.65,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: TextField(
              onChanged: (value) {},
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 30,
                ),
                hintText: "Tìm kiếm...",
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
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
