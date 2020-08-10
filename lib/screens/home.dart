import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Count Calories'),
      ),
      body: FloatingActionButton(
        onPressed: () async {
          final String barcode = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Cancel", true, ScanMode.BARCODE);

          ProductResult pr = await getProduct(barcode);
          Nutriments n = pr.product.nutriments;
          n.toData().forEach((key, value) {
            print('key $key value $value');
          });
          // print((await searchProduct()).map((element) {
          //   return element.toData().forEach((key, value) {
          //     print('Key: $key Value: $value');
          //   });
          // }));
        },
      ),
    );
  }

  Future<ProductResult> getProduct(String barcode) async {
    ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
        language: OpenFoodFactsLanguage.SPANISH, fields: [ProductField.ALL]);

    return await OpenFoodAPIClient.getProduct(configuration,
        user: User(userId: 'test'));
  }

  Future<List<Product>> searchProduct() async {
    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
            language: OpenFoodFactsLanguage.SPANISH,
            parametersList: <Parameter>[
          const OutputFormat(format: Format.JSON),
          const SearchSimple(active: true),
          const SearchTerms(terms: ['copos avena finos eco']),
        ],
            fields: [
          ProductField.ALL
        ]);
    SearchResult result = await OpenFoodAPIClient.searchProducts(
        User(userId: 'test'), configuration);

    return result.products;
  }
}
