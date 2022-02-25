import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/views/cart/widgets/body.dart';
import 'package:fluter_19pmd/views/checkout/checkout_page.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              color: Colors.white,
              width: 30,
              height: 30,
            ),
          ),
          title: const Text(
            "Giỏ hàng",
            style: TextStyle(fontSize: 26),
          ),
        ),
        body: const Body(),
        bottomNavigationBar: Row(
          children: [
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.07,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.delete),
                    Text(
                      "Xóa",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.07,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    buttonColor,
                  ),
                ),
                // ignore: void_checks
                onPressed: () {
                  checkOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.card_travel),
                    Text(
                      "CheckOut",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkOut() {
    if (RepositoryCart.cartClient.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CheckOutPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 10,
          backgroundColor: Colors.teal,
          content: const Text(
            'Hãy thêm sản phẩm',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Xem sản phẩm',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ), // SnackBarAction
        ));
    }
  }
}
