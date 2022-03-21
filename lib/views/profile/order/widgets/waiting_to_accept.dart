import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:fluter_19pmd/views/profile/order/details/order_details.dart';
import 'package:flutter/material.dart';

class WaitingToAccept extends StatefulWidget {
  const WaitingToAccept({Key key}) : super(key: key);

  @override
  State<WaitingToAccept> createState() => _WaitingToAcceptState();
}

class _WaitingToAcceptState extends State<WaitingToAccept> {
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
    return StreamBuilder<List<Invoices>>(
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
                        return itemCart(size, index, snapshot, context);
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

  Widget itemCart(size, index, snapshot, results) => InkWell(
        onTap: () {
          RepositoryInvoice.getInvoiceID = snapshot.data[index].id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetails(
                invoices: snapshot.data[index],
              ),
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
      children: [
        Text(
          "Tổng đơn : ${convertToVND(snapshot.data[index].total)}đ",
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF717171),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _button(
            icon: const Icon(Icons.cancel_presentation),
            text: 'Hủy đơn hàng',
            id: snapshot.data[index].id),
      ],
    );
  }

  Widget _button({icon, text, id}) => SizedBox(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              buttonColor,
            ),
          ),
          onPressed: () {
            checkOut(id);
          },
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

  void checkOut(id) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 10,
        backgroundColor: Colors.teal,
        content: const Text(
          'Bạn muốn hủy đơn hàng?',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () async {
            await RepositoryInvoice.cancelOrder(id);
            _invoiceSuccess.eventSink.add(InvoiceEvent.fetchWaitingToAccept);
          },
        ), // SnackBarAction
      ));
  }
}
