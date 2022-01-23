import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.2,
          width: size.width,
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.1),
          ),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      color: Colors.white,
                      child: Image.asset("assets/images/products/1.png"),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      height: size.height * 0.2,
                      width: size.width * 0.8,
                      child: Column(
                        children: const [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Săn sale sản phẩm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sản phẩm được khuyến mãi trong ngày hôm nay . Các bạn nhanh chân kẻo hết . Ngày hết hạn 25-12-2021 Sản phẩm được khuyến mãi trong ngày hôm nay ",
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
