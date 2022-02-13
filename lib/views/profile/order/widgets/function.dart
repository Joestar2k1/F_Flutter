import 'package:flutter/material.dart';

showMyAlertDialog(String message) {
  return showDialog(
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
            onPressed: () {},
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
  // if (openText == true)
  //               Stack(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         openText = !openText;
  //                       });
  //                     },
  //                     child: Container(
  //                       height: size.height,
  //                       color: Colors.black.withOpacity(0.5),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.bottomCenter,
  //                     child: Container(
  //                       height: size.height * 0.51,
  //                       color: Colors.white,
  //                       child: Column(
  //                         children: [
  //                           const SizedBox(
  //                             height: 10,
  //                           ),
  //                           const Text(
  //                             "Chọn lí do hủy",
  //                             style: TextStyle(
  //                               fontSize: 24,
  //                               fontWeight: FontWeight.normal,
  //                               color: Colors.black,
  //                               fontFamily: "RobotoSlab",
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 310,
  //                             child: ListView.builder(
  //                               itemCount: resons.length,
  //                               itemBuilder: (BuildContext context, int index) {
  //                                 return InkWell(
  //                                   onTap: () {},
  //                                   child: Row(
  //                                     children: [
  //                                       const SizedBox(height: 50),
  //                                       const SizedBox(width: 30),
  //                                       const Icon(
  //                                         Icons.double_arrow,
  //                                         color: Colors.orange,
  //                                       ),
  //                                       Text(
  //                                         resons[index],
  //                                         style: const TextStyle(
  //                                           fontSize: 20,
  //                                           color: Colors.grey,
  //                                           fontFamily: "RobotoSlab",
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  