import 'dart:async';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/review_api.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:fluter_19pmd/views/profile/order/details/order_details.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final _invoiceSuccess = InvoiceBloc();
  final _isLoading = LoadingBloc();
  final _commentController = TextEditingController();
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get selectedSink => _stateStreamController.sink;
  Stream<int> get selectedStream => _stateStreamController.stream;
  final _productStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get productSink => _productStreamController.sink;
  Stream<List<Product>> get productStream => _productStreamController.stream;
  @override
  void initState() {
    super.initState();

    _invoiceSuccess.eventSink.add(InvoiceEvent.fetchOrderHistory);
  }

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
    _isLoading.dispose();
    _stateStreamController.close();
    _commentController.dispose();
    _productStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Invoices>>(
        initialData: const [],
        stream: _invoiceSuccess.invoiceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15,
                              ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final currentTime = DateTime.now();
                            final orderDate = DateTime.parse(
                                snapshot.data[index].dateCreated.toString());
                            final results = currentTime.difference(orderDate);

                            return itemCart(size, index, snapshot, results);
                          }),
                    ),
                  ],
                ),
                _rating(size),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "Bạn không có đơn xác nhận",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        });
  }

  Widget _rating(Size size) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: _isLoading.loadingStream,
        builder: (context, state) {
          return AnimatedContainer(
            height: state.data ? 500 : 0,
            width: size.width,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, -1),
                  color: Colors.black,
                  blurRadius: 10.0,
                ),
              ],
              color: Colors.white,
            ),
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: StreamBuilder<int>(
                initialData: 6,
                stream: selectedStream,
                builder: (context, state2) {
                  return StreamBuilder<List<Product>>(
                      initialData: null,
                      stream: productStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Nội dung đánh giá',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 60),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        _isLoading.loadingSink.add(false);
                                        _commentController.text = "";
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.blue.shade400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Container(
                              //   margin: const EdgeInsets.only(left: 10),
                              //   height: 50,
                              //   child: ListView.separated(
                              //       scrollDirection: Axis.horizontal,
                              //       itemBuilder: (context, index) {
                              //         return const Card(
                              //           elevation: 10,
                              //           child: Text(
                              //             'Tất cả',
                              //             style: TextStyle(fontSize: 20),
                              //           ),
                              //         );
                              //       },
                              //       separatorBuilder: (context, index) =>
                              //           const SizedBox(width: 10),
                              //       itemCount: snapshot.data.length),
                              // ),
                              Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: _commentController,
                                  minLines: 5,
                                  maxLines: null,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: 'Viết gì đó ......',
                                      border: const OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                      )),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 60,
                                width: size.width,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return _itemStar(index, state2);
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemCount: 5),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _button(
                                    text: 'Gửi',
                                    icon: const Icon(Icons.send),
                                    press: () async {
                                      var data = await RepositoryReview.post(
                                        starNumber: state2.data + 1,
                                        content: _commentController.text,
                                        productID: snapshot.data,
                                      );
                                      _isLoading.loadingSink.add(false);
                                      if (data == 200) {
                                        message();
                                      }
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          );
        });
  }

  Widget _itemStar(int index, state) {
    return InkWell(
      onTap: () {
        state.data == index ? selectedSink.add(6) : selectedSink.add(index);
      },
      child: Card(
        color: (state.data == index) ? Colors.yellow : Colors.white,
        shadowColor: Colors.grey.shade400,
        elevation: 7,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${index + 1} sao',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemCart(size, index, snapshot, results) => InkWell(
        onTap: () {
          RepositoryInvoice.getInvoiceID = snapshot.data[index].id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderDetails(),
            ),
          );
        },
        child: Card(
          shadowColor: Colors.teal,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset('assets/images/icons-png/invoice.png'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    _contentCardRight(snapshot, index, size, results),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _contentCardRight(snapshot, index, size, results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tổng đơn : ${convertToVND(snapshot.data[index].total)}đ",
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF717171),
            fontWeight: FontWeight.bold,
          ),
        ),
        _button(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            text: 'Mua tiếp'),
        (results.inDays >= 0 && results.inDays <= 2)
            ? InkWell(
                onTap: () {
                  _isLoading.loadingSink.add(true);
                  _commentController.text = "";
                  // productSink.add(snapshot.data[index].products);
                },
                child: Text(
                  "Đánh giá",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Text(
                "Chưa đánh giá",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade400,
                ),
              )
      ],
    );
  }

  Widget _button({icon, text, press}) => SizedBox(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              buttonColor,
            ),
          ),
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  void message() async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        elevation: 10,
        backgroundColor: Colors.teal,
        content: Text(
          'Bình luận thành công',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 3),
        // SnackBarAction
      ));
  }
}
