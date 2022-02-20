import 'package:flutter/material.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đơn hàng của bạn",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: size.height * 0.15,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "x1",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              "Dâu tằm",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "100.000đ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
