import 'package:fluter_19pmd/bloc/counter_event.dart';
import 'package:fluter_19pmd/bloc/counter_state.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/cart/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);
  final _counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(15.0),
              height: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: InkWell(
                        onTap: () {},
                        child:
                            Image.asset("assets/images/icons-png/trash.png")),
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    color: buttonColor,
                    child: Image.asset("assets/images/products/1.png"),
                  ),
                  Column(
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
                      _buildItemInfo(text: "Giá (Kg) : \$", number: 2),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildItemInfo(text: "Số lượng  tồn kho :", number: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      _counter(size),
                    ],
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
        )),
        const Align(
            alignment: Alignment.bottomCenter, child: BottomNavBarCart()),
      ],
    );
  }

  Widget _buildItemInfo({String text, int number}) => RichText(
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

  Widget _counter(size) => SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    _counterBloc.eventSink.add(CounterEvent.decrement);
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
            ),
            Text(
              123.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  _counterBloc.eventSink.add(CounterEvent.increment);
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
}
