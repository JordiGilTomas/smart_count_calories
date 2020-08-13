import 'package:openfoodfacts/openfoodfacts.dart';

class Food {
  static Future<ProductResult> getProduct(String barcode) async {
    ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
        language: OpenFoodFactsLanguage.SPANISH, fields: [ProductField.ALL]);

    return await OpenFoodAPIClient.getProduct(configuration,
        user: User(userId: 'test'));
  }
}
