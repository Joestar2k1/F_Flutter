import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key key}) : super(key: key);
  String type;
  String price;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),
            _buildItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem() => Column(
        children: [
          _buildText('Chọn loại'),
          const SizedBox(height: 30.0),
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              _buildList(text: "Trái cây", press: () => type == 'Trái cây'),
              _buildList(text: "Thịt", press: () {}),
              _buildList(text: "Thức uống", press: () {}),
              _buildList(text: "Rau củ", press: () {}),
            ],
          ),
          const SizedBox(height: 30.0),
          _buildText('Chọn giá'),
          const SizedBox(height: 30.0),
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              _buildList(text: "0đ-50.000đ", press: () => price == '50000'),
              _buildList(text: "50.000đ-100.000đ", press: () {}),
              _buildList(text: "100.000đ trở đi", press: () {}),
            ],
          ),
          _submit(type, price),
        ],
      );

  Widget _buildText(text) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 23,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildList({text, Function press}) => InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: 60,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.grey.shade400),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      );

  Widget _submit(type, price) => Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            print(type + price);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: const BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: 50,
            width: 180,
            child: const Center(
                child: Text('Áp dụng',
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          ),
        ),
      );
}
