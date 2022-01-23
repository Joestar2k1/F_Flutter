import 'package:flutter/material.dart';

class UserReview extends StatelessWidget {
  const UserReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.35,
                height: 1,
                color: Colors.black,
              ),
              const Text(
                "Đánh giá",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                width: size.width * 0.35,
                height: 1,
                color: Colors.black,
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: const CircleAvatar(
                          backgroundImage: AssetImage(
                        "assets/images/person/a.png",
                      )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Nguyễn Hoài Chương",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  color: Colors.grey,
                  child: const Text(
                    "Sản phẩm thật tuyệt vời, cảm ơn bạn đã bán ra các sản phẩm chất lượng cho mình, ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      height: 1.5,
                      // overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
