import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeReader extends StatelessWidget {
  BarcodeReader({this.onRead});
  final Function onRead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        child: RaisedButton(
            onPressed: () async => onRead(await getBarcode()),
            // onPressed: () async => onRead('4008713756661'),
            child: Text('Leer código de barras')),
      ),
    );
  }

  Future<String> getBarcode() async => FlutterBarcodeScanner.scanBarcode(
      "#ff6666", "Cancel", true, ScanMode.BARCODE);
}
