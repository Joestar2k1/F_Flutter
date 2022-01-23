import 'package:fluter_19pmd/views/details_product/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ImgWidthPrice extends StatelessWidget {
  const ImgWidthPrice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.teal.shade200],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Dâu tằm",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "RobotoSlab",
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "\$3/Kg ",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "RobotoSlab",
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Hero(
                  tag: 1,
                  child: Image.asset(
                    "assets/images/products/1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const AppBarDetails(),
        ],
      ),
    );
  }
}
