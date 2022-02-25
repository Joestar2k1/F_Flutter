import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/invoiceDetails_models.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:fluter_19pmd/views/profile/order/details/widgets/invoice_details.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _invoiceBLoc = InvoiceBloc();
  @override
  void initState() {
    _invoiceBLoc.eventSink.add(InvoiceEvent.orderDetails);
    super.initState();
  }

  @override
  void dispose() {
    _invoiceBLoc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: StreamBuilder<InvoiceDetails>(
          initialData: InvoiceDetails(),
          stream: _invoiceBLoc.detailsStream,
          builder: (context, snapshot) {
            if (snapshot.data.id == null) {
              return Column(
                children: [
                  SizedBox(height: size.height * 0.4),
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Đơn hàng của bạn",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfo(
                              title: "Mã đơn hàng: ",
                              value: "#${snapshot.data.id}."),
                          const SizedBox(height: 15),
                          _buildInfo(
                              title: "Thời gian đặt hàng: ",
                              value: snapshot.data.dateCreated),
                          const SizedBox(height: 15),
                          _buildInfo(title: "Thanh toán: ", value: "Tiền mặt."),
                          const SizedBox(height: 15),
                          _buildInfo(
                            title: "Trạng thái đơn hàng: ",
                            value: (snapshot.data.status == 1)
                                ? "Đang xác nhận."
                                : "",
                          ),
                          const SizedBox(height: 15),
                          const Center(
                            child: Text(
                              "Chi tiết đơn hàng",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _nameTable("Sản phẩm"),
                                const SizedBox(width: 20),
                                _nameTable("Giá bán"),
                                const SizedBox(width: 20),
                                _nameTable("Số lượng"),
                                const SizedBox(width: 20),
                                _nameTable("Ảnh "),
                              ],
                            ),
                          ),
                          Details(itemProduct: snapshot.data.products),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }

  Widget _buildInfo({String title, String value}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
          ],
        ),
      );

  Widget _nameTable(title) => Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.teal,
          fontWeight: FontWeight.bold,
        ),
      );
}
