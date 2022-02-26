import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/views/details_product/counter_bloc.dart';
import 'package:flutter/material.dart';

class DescriptionWidthCounter extends StatefulWidget {
  const DescriptionWidthCounter(
      {Key key, this.description, this.stock, this.price})
      : super(key: key);

  final String description;
  final int stock;
  final int price;

  @override
  State<DescriptionWidthCounter> createState() =>
      _DescriptionWidthCounterState();
}

class _DescriptionWidthCounterState extends State<DescriptionWidthCounter> {
  final _counterBloc = CounterDetailsBloc();
  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Thông tin sản phẩm",
              style: TextStyle(
                fontSize: 23,
                fontFamily: "RobotoSlab",
                color: Colors.orange.shade400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              height: 120,
              width: size.width,
              child: Text(
                widget.description,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                  fontFamily: "RobotoSlab",
                  color: textColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Số lượng:",
                style: TextStyle(fontSize: 22, color: Colors.teal),
              ),
              _counter(),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng: ",
                style: TextStyle(fontSize: 22, color: Colors.teal),
              ),
              StreamBuilder<int>(
                  initialData: widget.price,
                  stream: _counterBloc.totalStream,
                  builder: (context, snapshot) {
                    return Text(
                      "${convertToVND(snapshot.data)}đ",
                      style: const TextStyle(fontSize: 20),
                    );
                  }),
            ],
          )
          // const BottomNav(),
        ],
      ),
    );
  }

  Widget _counter() => StreamBuilder<int>(
      initialData: 1,
      stream: _counterBloc.counterStream,
      builder: (context, snapshot) {
        return SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      _counterBloc.eventSink.add(CounterEvent.decrement);
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                snapshot.data.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    if (snapshot.data < widget.stock) {
                      _counterBloc.eventSink.add(CounterEvent.increment);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
