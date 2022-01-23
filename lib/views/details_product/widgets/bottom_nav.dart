import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width / 2,
          height: size.height * 0.08,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red.shade400),
            ),
            onPressed: () {},
            child: const Text(
              "Thêm giỏ hàng",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width / 2,
          height: size.height * 0.08,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
            ),
            onPressed: () {},
            child: const Text(
              "Checkout",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
