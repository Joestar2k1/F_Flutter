import 'dart:async';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';

class InvoiceBloc {
  final _stateStreamController = StreamController<List<Invoices>>();
  StreamSink<List<Invoices>> get _invoiceSink => _stateStreamController.sink;
  Stream<List<Invoices>> get invoiceStream => _stateStreamController.stream;

  final _orderDetailsController = StreamController<Invoices>();
  StreamSink<Invoices> get _detailsSink => _orderDetailsController.sink;
  Stream<Invoices> get detailsStream => _orderDetailsController.stream;

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
      } else if (event == InvoiceEvent.fetchOnDelivery) {
        var invoiceSuccess = await RepositoryInvoice.getOnDelivery();
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
      } else if (event == InvoiceEvent.orderDetails) {
        var invoice = await RepositoryInvoice.orderDetails();
        _detailsSink.add(invoice);
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
    _orderDetailsController.close();
  }
}
