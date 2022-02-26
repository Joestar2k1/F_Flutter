// import 'dart:async';

// class LoadQuantityCart {
//   //load-quantity-cart
//   final _cartQuantity = StreamController<int>();
//   StreamSink<int> get cartQuantitySink => _cartQuantity.sink;
//   Stream<int> get cartQuantityStream => _cartQuantity.stream;
//   void dispose() {
//     _cartQuantity.close();
//   }
// }
//  TextField(
//               onChanged: (value) {},
//               decoration: const InputDecoration(
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(
//                   vertical: 12,
//                   horizontal: 30,
//                 ),
//                 hintText: "Tìm kiếm...",
//                 hintStyle: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 20,
//                   // fontWeight: FontWeight.bold,
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   size: 25,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),