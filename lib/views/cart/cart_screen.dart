import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
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
  final _deleteBloc = LoadingBloc();
  @override
  void dispose() {
    super.dispose();
    _deleteBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder<bool>(
          initialData: false,
          stream: _deleteBloc.loadingStream,
          builder: (context, state) {
            return Scaffold(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
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
              body: Body(
                openDelete: state.data,
              ),
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
                        children: [
                          (state.data)
                              ? const Icon(Icons.check)
                              : const Icon(Icons.delete),
                          (state.data)
                              ? const Text(
                                  "Hoàn tất",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
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
                        if (RepositoryCart.cartClient.length > 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckOutPage(),
                            ),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDiaLogCustom(
                                    title: "Cảnh báo",
                                    content:
                                        "-Giỏ hàng bạn trống, không thể tới trang thanh toán.",
                                    gif: "assets/gif/warning.gif",
                                    textButton: "Okay");
                              });
                        }
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
            );
          }),
    );
  }
}
