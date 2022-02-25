import 'package:flutter/material.dart';

const buttonColor = Color(0xFF1abc9c);
const double numberPadding = 20.0;
const textColor = Color(0xFF222f3e);

Widget _buttonRemove(title) => Center(
      child: SizedBox(
        height: 50,
        width: 200,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
          onPressed: () {},
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
