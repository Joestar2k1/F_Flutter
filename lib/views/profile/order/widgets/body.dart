import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  showMyAlertDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Hủy đơn hàng",
              style: TextStyle(fontSize: 25, color: Colors.orange.shade300),
            ),
          ),
          content: Text(
            "Bạn muốn hủy đơn hàng vì $message",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontFamily: "RobotoSlab",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  openText = !openText;
                });
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange.shade300,
                  fontFamily: "RobotoSlab",
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<String> resons = [
    "Đổi ý, mua sản phẩm khác.",
    "Đổi địa chỉ giao hàng.",
    "Không đủ điều kiện kinh tế.",
    "Thích thì hủy.",
  ];

  bool openText = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: const Border(
              top: BorderSide(
                width: 1.0,
                // ignore: use_full_hex_values_for_flutter_colors
                color: Color(0xffffdfdfdf),
              ),
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 600,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemCart(size);
                    }),
              ),
              if (openText == true)
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          openText = !openText;
                        });
                      },
                      child: Container(
                        height: size.height,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * 0.51,
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Chọn lí do hủy",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontFamily: "RobotoSlab",
                              ),
                            ),
                            SizedBox(
                              height: 310,
                              child: ListView.builder(
                                itemCount: resons.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      showMyAlertDialog(resons[index]);
                                    },
                                    child: Row(
                                      children: [
                                        const SizedBox(height: 50),
                                        const SizedBox(width: 30),
                                        const Icon(
                                          Icons.double_arrow,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          resons[index],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontFamily: "RobotoSlab",
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget ItemCart(size) => Card(
        shadowColor: Colors.teal,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rau củ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF34848),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                  ),
                  const SizedBox(
                    height: 30,
                    width: 45,
                    child: Text(
                      "x10",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Image.asset('assets/images/products/7.png'),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rau salad",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xFF717171),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "\$2",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF717171),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            openText = !openText;
                          });
                        },
                        child: const Text(
                          'Hủy đơn hàng',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  RichText buildText({String title, int vla}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: "RobotoSlab",
              color: textColor,
            ),
          ),
          if (title == "Giá bán")
            TextSpan(
              text: " : $vla\$",
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "RobotoSlab",
                color: textColor,
              ),
            ),
          if (title == "Số lượng")
            TextSpan(
              text: " : $vla kg",
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "RobotoSlab",
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }
}
