import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/views/details_product/counter_bloc.dart';
import 'package:flutter/material.dart';

class DescriptionWidthCounter extends StatefulWidget {
  const DescriptionWidthCounter({Key key, this.description, this.stock})
      : super(key: key);

  final String description;
  final int stock;

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
            height: 10,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Số lượng:",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 30),
              _counter(),
            ],
          ),
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
          width: 150,
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
