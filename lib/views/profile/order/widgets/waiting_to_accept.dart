import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:flutter/material.dart';

class WaitingToAccept extends StatefulWidget {
  const WaitingToAccept({Key key}) : super(key: key);

  @override
  State<WaitingToAccept> createState() => _WaitingToAcceptState();
}

class _WaitingToAcceptState extends State<WaitingToAccept> {
  // List<String> resons = [
  //   "Đổi ý, mua sản phẩm khác.",
  //   "Đổi địa chỉ giao hàng.",
  //   "Không đủ điều kiện kinh tế.",
  //   "Thích thì hủy.",
  // ];
  final _invoiceSuccess = InvoiceBloc();
  @override
  void initState() {
    super.initState();
    _invoiceSuccess.eventSink.add(InvoiceEvent.fetchWaitingToAccept);
  }

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Product>>(
        initialData: const [],
        stream: _invoiceSuccess.invoiceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                        return itemCart(size, index, snapshot);
                      }),
                ),
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

  Widget itemCart(size, index, snapshot) => Card(
        shadowColor: Colors.teal,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    snapshot.data[index].type,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF34848),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                  ),
                  SizedBox(
                    height: 30,
                    width: 45,
                    child: Text(
                      'x${snapshot.data[index].quantity}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Image.asset(
                        'assets/images/products/${snapshot.data[index].image}'),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index].name,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Color(0xFF717171),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${snapshot.data[index].price}đ",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xFF717171).withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Hủy đơn hàng',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
