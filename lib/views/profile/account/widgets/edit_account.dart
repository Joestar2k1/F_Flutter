import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';

class EditAccountPage extends StatelessWidget {
  EditAccountPage({Key key}) : super(key: key);
  var array = [];
  getObject(Object x) {
    for (var value in x) {
      array.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final object = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    getObject(object);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFf1f2f6),
        appBar: AppBar(
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop((context));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: buttonColor,
            ),
          ),
          title: const Text(
            "Thiết lập tài khoản",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check),
              color: buttonColor,
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: inputEditAccount(size, context, array),
      ),
    );
  }

  Widget inputEditAccount(size, context, array) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  array[0],
                  style: const TextStyle(color: textColor, fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height * 0.08,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: TextField(
                  controller: TextEditingController(
                    text: array[1],
                  ),
                  style:
                      const TextStyle(color: Colors.blueAccent, fontSize: 20),
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
