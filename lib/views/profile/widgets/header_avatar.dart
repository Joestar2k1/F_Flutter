import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:flutter/material.dart';

class HeaderWithAvatar extends StatelessWidget {
  const HeaderWithAvatar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.33,
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                buildHeader(size, context),
                builAvatar(size),
              ],
            ),
          ),
          buildNameUser(size),
        ],
      ),
    );
  }

  Stack builAvatar(Size size) {
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.2,
          width: size.width * 0.37,
          child: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/person/${RepositoryUser.info.avatar}"),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: size.height * 0.05,
            width: size.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
            ),
          ),
        ),
      ],
    );
  }

  Row buildHeader(Size size, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: size.width,
          height: size.height * 0.07,
          child: const Center(
            child: Text(
              "Hồ sơ",
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                letterSpacing: 5,
                fontFamily: "RobotoSlab",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Positioned buildNameUser(Size size) {
    return Positioned(
      left: size.width / 5,
      bottom: 5,
      child: Container(
        width: size.width * 0.6,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            RepositoryUser.info.fullName,
            style: const TextStyle(
              color: textColor,
              fontSize: 18,
              letterSpacing: 1,
              fontFamily: "RobotoSlab",
            ),
          ),
        ),
      ),
    );
  }
}
