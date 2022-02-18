import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';

class InvoiceBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _invoiceSink => _stateStreamController.sink;
  Stream<List<Product>> get invoiceStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<InvoiceEvent>();
  StreamSink<InvoiceEvent> get eventSink => _eventStreamController.sink;
  Stream<InvoiceEvent> get _eventStream => _eventStreamController.stream;
  InvoiceBloc() {
    _eventStream.listen((event) async {
      if (event == InvoiceEvent.fetchOrderHistory) {
        handelEventFetchOrderHistory();
      } else if (event == InvoiceEvent.fetchWaitingToAccept) {
        handelEventFetchWaitingToAccept();
      } else if (event == InvoiceEvent.fetchPickingUpGoods) {
        handelEventFetchPickingUpGoods();
      }
    });
  }
  void handelEventFetchOrderHistory() async {
    var invoiceSuccess = await RepositoryInvoice.orderHistory();
    try {
      if (invoiceSuccess != null) {
        await Future.delayed(const Duration(seconds: 1));
        _invoiceSink.add(invoiceSuccess);
      } else {
        _invoiceSink.addError('get products don\'t completed');
      }
    } on Exception {
      _invoiceSink.addError('get products don\'t completed');
    }
  }

  void handelEventFetchWaitingToAccept() async {
    var invoiceSuccess = await RepositoryInvoice.waitingToAccept();
    try {
      if (invoiceSuccess != null) {
        await Future.delayed(const Duration(seconds: 1));
        _invoiceSink.add(invoiceSuccess);
      } else {
        _invoiceSink.addError('get products don\'t completed');
      }
    } on Exception {
      _invoiceSink.addError('get products don\'t completed');
    }
  }

  void handelEventFetchPickingUpGoods() async {
    var invoiceSuccess = await RepositoryInvoice.pickingUpGoods();
    try {
      if (invoiceSuccess != null) {
        await Future.delayed(const Duration(seconds: 1));
        _invoiceSink.add(invoiceSuccess);
      } else {
        _invoiceSink.addError('get products don\'t completed');
      }
    } on Exception {
      _invoiceSink.addError('get products don\'t completed');
    }
  }

  void dispose() {
    _stateStreamController.close();
  }
}
