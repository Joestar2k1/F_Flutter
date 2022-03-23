import 'package:fluter_19pmd/views/result_filter/list_filter.dart';
import 'package:flutter/material.dart';

class ResultFilter extends StatefulWidget {
  const ResultFilter({Key key}) : super(key: key);

  @override
  State<ResultFilter> createState() => _ResultFilterState();
}

class _ResultFilterState extends State<ResultFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal.shade200],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Center(
          child: Text(
            "Kết quả",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: const [
                ItemList(
                  title: 'Lọc sản phẩm',
                  types: ['Trái cây', 'Thịt', 'Thức uống', 'Rau củ'],
                ),
                ItemList(
                  title: 'Giá tiền',
                  types: ['50k trở xuống', '50k-100k', '100k trở lên'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
