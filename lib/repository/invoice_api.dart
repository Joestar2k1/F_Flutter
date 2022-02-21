import 'package:fluter_19pmd/models/invoice_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepositoryInvoice {
  static var getContext;
  static double heightMyOrder() {
    double dem = 0;
    for (var i = 1; i <= RepositoryCart.cartClient[0].products.length; i++) {
      dem += 0.075;
    }
    return dem;
  }

  static Future<void> payment() async {
    var client = http.Client();
    var response = await client.put(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/payment/${RepositoryCart.cartClient[0].id}'),
      body: ({
        'address': RepositoryUser.info.address[0].name,
      }),
    );
    if (response.statusCode == 200) {
      Navigator.push(
          getContext,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      print('Lỗi');
    }
  }

  static Future<List<Invoice>> orderHistory() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getInvoiceSuccess/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      List<Invoice> invoices;
      var jsonString = response.body;
      invoices = invoiceFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<List<Invoice>> waitingToAccept() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getWaitingToAccept/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var invoices = invoiceFromJson(jsonString);

      return invoices;
    } else {
      return null;
    }
  }

  static Future<List<Invoice>> pickingUpGoods() async {
    var client = http.Client();
    List<Invoice> invoices;

    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getPickingUpGood/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoiceFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<List<Invoice>> getOnDelivery() async {
    var client = http.Client();
    List<Invoice> invoices;

    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/invoices/getOnDelivery/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoiceFromJson(jsonString);

      return invoices;
    }
    return null;
  }
}
