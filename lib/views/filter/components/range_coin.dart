import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Chọn giá (${currentRangeCoin.start.toInt()}K - ${currentRangeCoin.end.toInt()}K)",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.6,
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
    );
  }
}
