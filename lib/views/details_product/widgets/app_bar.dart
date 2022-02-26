import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarDetails extends StatelessWidget {
  const AppBarDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_back.svg",
              color: Colors.white,
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}
