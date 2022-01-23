import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({Key key}) : super(key: key);

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: ListView.separated(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 140,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: InkWell(
                    onTap: () {},
                    child: Image.asset("assets/images/icons-png/trash.png")),
              ),
              Container(
                width: size.width * 0.3,
                height: size.height * 0.17,
                color: Colors.grey.withOpacity(0.2),
                child: Image.asset("assets/images/products/1.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dâu",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildItemInfo(text: "Giá (Kg) : \$", number: 2),
                    const SizedBox(
                      height: 10,
                    ),
                    buildItemInfo(text: "Số lượng  tồn kho :", number: 10),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 0.4,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                // if (postCarts[index].quantity > 0) {
                                //   postCarts[index].quantity--;
                                //   handelCounterRemove(index);
                                // }
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Container(
                            width: size.width * 0.003,
                            height: size.height * 0.05,
                            color: Colors.black12,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width * 0.15,
                            height: size.height * 0.05,
                            child: Center(
                              child: Text(
                                1.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.003,
                            height: size.height * 0.05,
                            color: Colors.black12,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                // if (postCarts[index].quantity <
                                //     postCarts[index].stock) {
                                //   postCarts[index].quantity++;
                                //   // handelCounterAdd(index);
                                // }
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 20,
        );
      },
    ));
  }

  RichText buildItemInfo({String text, int number}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: number.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
