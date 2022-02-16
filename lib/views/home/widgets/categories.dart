// import 'package:fluter_19pmd/constant.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class Categories extends StatelessWidget {
//   Categories({
//     Key key,
//   }) : super(key: key);
//   List categories = List.unmodifiable([
//     {
//       'title': 'Trái cây',
//       'img': 'assets/images/icons-png/fruit.png',
//       'color': 0xFF05c46b
//     },
//     {
//       'title': 'Thịt',
//       'img': 'assets/images/icons-png/meat.png',
//       'color': 0xFFffdd59
//     },
//     {
//       'title': 'Thức uống',
//       'img': 'assets/images/icons-png/drink.png',
//       'color': 0xFF4bcffa,
//     },
//     {
//       'title': 'Rau củ',
//       'img': 'assets/images/icons-png/vegetable.png',
//       'color': 0xFFffb8b8,
//     },
//   ]);
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Danh mục",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontFamily: "RobotoSlab",
//                   color: textColor,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Row(
//                   children: const [
//                     Text(
//                       "Xem tất cả",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontFamily: "RobotoSlab",
//                         color: textColor,
//                       ),
//                     ),
//                     Icon(
//                       Icons.double_arrow,
//                       color: textColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 115,
//           child: ListView.separated(
//             separatorBuilder: (context, index) => const SizedBox(
//               width: 0,
//             ),
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemCount: categories.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(left: 15),
//                     width: size.width * 0.25,
//                     height: size.height * 0.1,
//                     decoration: BoxDecoration(
//                       color: Color(categories[index]['color']),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(20),
//                       ),
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => CateGoryScreen(),
//                         //   ),
//                         // );
//                       },
//                       child: Image.asset(
//                         categories[index]['img'],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     categories[index]['title'],
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontFamily: "RobotoSlab",
//                       color: Colors.orange.shade700,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
