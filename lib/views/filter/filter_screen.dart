import 'package:fluter_19pmd/views/filter/components/body_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFf1f2f6),
        appBar: buildAppbar(context),
        body: const SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Body(),
        ),
      ),
    );
  }

  AppBar buildAppbar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal.shade200],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          'assets/icons/arrow_back.svg',
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Lọc dữ liệu",
        style: TextStyle(fontSize: 26),
      ),
    );
  }
}
