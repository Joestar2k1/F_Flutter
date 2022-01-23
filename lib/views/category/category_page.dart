import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: buildTabbar(),
            elevation: 0,
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
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Danh mục",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          body: bodyTabbar(),
          // body: Body(),
        ),
      ),
    );
  }

  Widget bodyTabbar() => const TabBarView(
        children: [
          Text("1"),
          Text("2"),
          Text("3"),
          Text("4"),
          Text("5"),
        ],
      );
  Widget buildTabbar() => const TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        tabs: [
          Tab(
            child: Text(
              "Tất cả",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Trái cây",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Thịt",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Thức uống",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Rau củ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
