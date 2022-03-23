import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/services/filter/filter_stream.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterPage extends StatefulWidget {
  const FilterPage({Key key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final filterBloc = FilterBloc();
  @override
  void dispose() {
    super.dispose();
    filterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),
            _buildItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem() => StreamBuilder<String>(
      initialData: '',
      stream: filterBloc.typeStream,
      builder: (context, type) {
        return StreamBuilder<int>(
            initialData: -10,
            stream: filterBloc.priceStream,
            builder: (context, price) {
              return Column(
                children: [
                  _buildText('Chọn loại'),
                  const SizedBox(height: 30.0),
                  Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      _buildList(
                          text: "Trái cây",
                          type: type.data,
                          press: () {
                            filterBloc.typeSink.add("Trái cây");
                          }),
                      _buildList(
                          text: "Thịt",
                          type: type.data,
                          press: () {
                            filterBloc.typeSink.add("Thịt");
                          }),
                      _buildList(
                          text: "Thức uống",
                          type: type.data,
                          press: () {
                            filterBloc.typeSink.add("Thức uống");
                          }),
                      _buildList(
                          text: "Rau củ",
                          type: type.data,
                          press: () {
                            filterBloc.typeSink.add("Rau củ");
                          }),
                      _buildList(
                          text: "Tất cả",
                          type: type.data,
                          press: () {
                            filterBloc.typeSink.add("Tất cả");
                          }),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  _buildText('Chọn giá'),
                  const SizedBox(height: 30.0),
                  Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      _buildListPrice(
                        text: "0đ-50.000đ",
                        index: 0,
                        stream: price.data,
                        press: () {
                          filterBloc.priceSink.add(0);
                        },
                      ),
                      _buildListPrice(
                        text: "50.000đ-100.000đ",
                        index: 1,
                        stream: price.data,
                        press: () {
                          filterBloc.priceSink.add(1);
                        },
                      ),
                      _buildListPrice(
                        text: "100.000đ trở đi",
                        index: 2,
                        stream: price.data,
                        press: () {
                          filterBloc.priceSink.add(2);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _submit(type: type.data, price: price.data),
                  ),
                  (price.data == -1)
                      ? const Text(
                          "Vui lòng chọn giá",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                  (type.data == null)
                      ? const Text(
                          "Vui lòng chọn loại",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ],
              );
            });
      });

  Widget _buildText(text) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 23,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildList({text, Function press, String type}) => InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: 60,
          width: 120,
          decoration: BoxDecoration(
            color: text == type ? Colors.teal : Colors.white,
            border: Border.all(width: 2.0, color: Colors.grey.shade400),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 19,
                color: text == type ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      );
  Widget _buildListPrice({text, Function press, int index, stream}) => InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: 60,
          width: 120,
          decoration: BoxDecoration(
            color: index == stream ? Colors.teal : Colors.white,
            border: Border.all(width: 2.0, color: Colors.grey.shade400),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 19,
                color: index == stream ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      );
  Widget _submit({type, price}) => Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            if (price == -10) {
              filterBloc.priceSink.add(-1);
            }
            if (type == '') {
              filterBloc.typeSink.add(null);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: const BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: 50,
            width: 180,
            child: const Center(
                child: Text('Áp dụng',
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          ),
        ),
      );
}
