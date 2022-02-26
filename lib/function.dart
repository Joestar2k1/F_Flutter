import 'package:flutter/material.dart';

String convertToVND(int price) {
  var current = price.toString().split('');
  var newPrice = '';

  if (current.length == 5) {
    current.insert(2, '.');
    current.forEach((element) {
      newPrice += element;
    });
  } else if (current.length == 6) {
    current.insert(3, '.');
    current.forEach((element) {
      newPrice += element;
    });
  } else if (current.length == 4) {
    current.insert(1, '.');
    current.forEach((element) {
      newPrice += element;
    });
  } else {
    newPrice = price.toString();
  }
  return newPrice.toString();
}
