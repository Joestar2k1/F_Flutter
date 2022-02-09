import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarCart extends StatefulWidget {
  const BottomNavBarCart({Key key}) : super(key: key);

  @override
  _BottomNavBarCartState createState() => _BottomNavBarCartState();
}

class _BottomNavBarCartState extends State<BottomNavBarCart> {
  bool ischeck = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: ischeck,
                  onChanged: (bool value) {
                    setState(() {
                      ischeck = value;
                      // handelCheckboxAll(ischeck);
                    });
                  },
                ),
                const Text(
                  "Chọn tất cả",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFE65100),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: const [
                  Text(
                    "Tổng tiền:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "\$}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _button(size),
      ],
    );
  }

  Widget _button(size) => Row(
        children: [
          SizedBox(
            width: size.width * 0.5,
            height: size.height * 0.06,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonColor),
              ),
              onPressed: () {
                setState(() {});
              },
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
            height: size.height * 0.06,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttonColor,
                ),
              ),
              onPressed: () {},
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
      );
}
