import 'package:flutter/material.dart';
import 'package:moblie_project/Screens/filter/components/range_coin.dart';

import 'package:moblie_project/constants.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final prType = TextEditingController();
  final prText = TextEditingController();
  bool isSelectedType = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 50,
        ),
        builType(size),
        const SizedBox(
          height: 50,
        ),
        buildName(size),
        const SizedBox(
          height: 50,
        ),
        const RangeCoin(),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: size.width,
            height: size.height * 0.07,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(cPrimaryGreenColor)),
              child: const Text(
                "Thực hiện",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryWhiteColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column buildName(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            "Nhập tên sản phẩm",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          height: size.height * 0.06,
          decoration: const BoxDecoration(
            color: cPrimaryWhiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextField(
            controller: prType,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Nhập",
              hintStyle: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column builType(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            "Chọn loại sản phẩm",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          height: size.height * 0.06,
          decoration: const BoxDecoration(
            color: cPrimaryWhiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextField(
            controller: prType,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Chọn",
              hintStyle: const TextStyle(
                fontSize: 18,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    isSelectedType = !isSelectedType;
                  });
                },
                child: (isSelectedType)
                    ? const Icon(Icons.arrow_drop_down)
                    : const Icon(Icons.arrow_right),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
