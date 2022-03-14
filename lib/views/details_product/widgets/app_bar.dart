import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarDetails extends StatelessWidget {
  const AppBarDetails({Key key, this.checkFavorite}) : super(key: key);
  final bool checkFavorite;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_back.svg",
              color: Colors.black,
              height: 40,
              width: 40,
            ),
          ),
          InkWell(
              onTap: () {},
              child: (checkFavorite)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 40,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.black,
                      size: 40,
                    )),
        ],
      ),
    );
  }
}
