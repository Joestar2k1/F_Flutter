import 'package:fluter_19pmd/views/profile/widgets/header_avatar.dart';
import 'package:fluter_19pmd/views/profile/widgets/item_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyProfile extends StatelessWidget {
  BodyProfile({Key key}) : super(key: key);

  heightContainer() {
    var dem = 0.0;
    for (int i = 1; i <= profiles.length; i++) {
      if (i % 2 != 0) {
        dem += 200;
      }
    }
    return dem;
  }

  final List profiles = List.unmodifiable([
    {'icon': "assets/images/icons-png/user.png", 'text': "Tài khoản"},
    {'icon': "assets/images/icons-png/delivery.png", 'text': "Đơn hàng"},
    {'icon': "assets/images/icons-png/settings.png", 'text': "Cài đặt"},
    {'icon': "assets/images/icons-png/Logout.png", 'text': "Đăng xuất"},
  ]);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: size.height / 3,
            width: size.width,
            child: const HeaderWithAvatar(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: heightContainer(),
            width: size.width,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: profiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30.0,
                  mainAxisSpacing: 30.0),
              itemBuilder: (BuildContext context, int index) {
                return ItemProfile(
                  index: index,
                  profiles: profiles,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
