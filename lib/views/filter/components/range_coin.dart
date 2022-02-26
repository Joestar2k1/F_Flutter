import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RangeCoin extends StatefulWidget {
  const RangeCoin({Key key}) : super(key: key);

  @override
  State<RangeCoin> createState() => _RangeCoinState();
}

class _RangeCoinState extends State<RangeCoin> {
  var currentRangeCoin = const RangeValues(30, 1000);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn giá (${currentRangeCoin.start.toInt()}K - ${currentRangeCoin.end.toInt()}K)",
            style: TextStyle(
              fontSize: 24,
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
          SizedBox(
            width: size.width,
            child: RangeSlider(
              min: 20,
              max: 2000,
              divisions: 100,
              activeColor: Colors.green,
              inactiveColor: textColor,
              values: currentRangeCoin,
              onChanged: (RangeValues rangeValues) {
                setState(() {
                  currentRangeCoin = rangeValues;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
