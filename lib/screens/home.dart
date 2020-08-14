import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smart_count_calories/components/barcode_reader.dart';
import 'package:smart_count_calories/components/product_card.dart';
import 'package:smart_count_calories/food.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductResult productResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Count Calories'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BarcodeReader(onRead: (barcode) async {
            productResult = (await Food.getProduct(barcode));
            setState(() {});
            if (productResult?.status == 1)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductCard(
                            product: productResult.product,
                          )));
          }),
          if (productResult != null && productResult?.status != 1)
            Center(child: Text(productResult?.statusVerbose)),
        ],
      )),
      // FloatingActionButton(
      //   onPressed: () {

      // async {
      // final String barcode = await FlutterBarcodeScanner.scanBarcode(
      //     "#ff6666", "Cancel", true, ScanMode.BARCODE);

      // ProductResult pr = await getProduct(barcode);
      // Nutriments n = pr.product.nutriments;
      // n.toData().forEach((key, value) {
      //   print('key $key value $value');
      // });
      // print((await searchProduct()).map((element) {
      //   return element.toData().forEach((key, value) {
      //     print('Key: $key Value: $value');
      //   });
      // }));
      // },
    );
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
