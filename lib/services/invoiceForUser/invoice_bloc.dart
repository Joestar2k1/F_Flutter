import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';

class InvoiceBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _invoiceSuccess => _stateStreamController.sink;
  Stream<List<Product>> get invoiceStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<InvoiceEvent>();
  StreamSink<InvoiceEvent> get eventSink => _eventStreamController.sink;
  Stream<InvoiceEvent> get _eventStream => _eventStreamController.stream;
  InvoiceBloc() {
    _eventStream.listen((event) async {
      if (event == InvoiceEvent.fetchInvoiceHistory) {
        var invoiceSuccess = await RepositoryInvoice.getInvoiceSuccess();
        try {
          if (invoiceSuccess != null) {
            await Future.delayed(const Duration(seconds: 1));
            _invoiceSuccess.add(invoiceSuccess);
          } else {
            _invoiceSuccess.addError('get products don\'t completed');
          }
        } on Exception {
          _invoiceSuccess.addError('get products don\'t completed');
        }
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
  }
}
