import 'dart:ui' as ui;
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/filter/components/range_coin.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<dynamic> categories = List.unmodifiable([
    {
      'text': "Trái cây",
      'isCheck': false,
    },
    {
      'text': "Thức uống",
      'isCheck': false,
    },
    {
      'text': "Thịt",
      'isCheck': false,
    },
    {
      'text': "Rau Củ",
      'isCheck': false,
    },
  ]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Danh mục",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 20),
                      const Offset(150, 20),
                      [
                        Colors.red,
                        Colors.teal,
                      ],
                    ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: size.width,
                padding: const EdgeInsets.all(30.0),
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 40),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categories[index]['text'],
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              Checkbox(
                                activeColor: Colors.green,
                                value: categories[index]['isCheck'],
                                onChanged: (bool newValue) {
                                  setState(() {
                                    categories[index]['isCheck'] = newValue;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const RangeCoin(),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: size.width,
            height: size.height * 0.07,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor)),
              child: const Text(
                "Thực hiện",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
