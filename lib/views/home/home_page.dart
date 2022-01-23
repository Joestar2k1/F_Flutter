import 'package:fluter_19pmd/views/category/category_page.dart';
import 'package:fluter_19pmd/views/home/widgets/body.dart';
import 'package:fluter_19pmd/views/home/widgets/search_icons.dart';
import 'package:fluter_19pmd/views/notification/notification_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //controller

  AnimationController animationController;
  int selectedIndex = 0;
  final screens = [
    Body(),
    const CategoryPage(),
    const NotificationPage(),
  ];
  final List _tabIcon = List.unmodifiable([
    {'icon': "assets/images/icons-png/home.png", 'title': "Home"},
    {'icon': "assets/images/icons-png/category.png", 'title': "Danh mục"},
    {'icon': "assets/images/icons-png/notification.png", 'title': "Thông báo"},
    {'icon': "assets/images/icons-png/me.png", 'title': "Me"},
  ]);
  void onTapChanges(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.3,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: (selectedIndex == 0)
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.teal.shade700,
                title: const SearchWithIcons(),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.teal.shade200],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              )
            : null,
        body: screens[selectedIndex],
        bottomNavigationBar: builNavBar(),
      ),
    );
  }

  Widget builNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.teal.shade200],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 0),
            color: Colors.grey,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _tabIcon.length,
          (index) {
            return InkWell(
              onTap: () {
                if (index != selectedIndex) {
                  onTapChanges(index);
                  animationController
                      .forward()
                      .then((value) => animationController.reverse());
                }
              },
              child: ScaleTransition(
                scale: animationController,
                child: Column(
                  children: [
                    Image.asset(
                      _tabIcon[index]['icon'],
                      color: (selectedIndex == index)
                          ? Colors.white
                          : Colors.white70,
                    ),
                    Text(
                      _tabIcon[index]['title'],
                      style: TextStyle(
                        color: (selectedIndex == index)
                            ? Colors.white
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
