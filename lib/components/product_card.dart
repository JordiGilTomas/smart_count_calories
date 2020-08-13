import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/RecommendedDailyIntake.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    List<ProductImage> productImages = product.selectedImages;
    Nutriments nutriments = product.nutriments;
    Iterable<MapEntry<String, Level>> levels =
        product.nutrientLevels.levels.entries;
    Map<String, dynamic> productJson = product.toJson();
    String isVegan =
        productJson['ingredients_analysis_tags'][0].toString().substring(3);
    String isVegetarian =
        productJson['ingredients_analysis_tags'][1].toString().substring(3);
    String isPalmOilFree =
        productJson['ingredients_analysis_tags'][2].toString().substring(3);

    return Expanded(
      child: ListView(
        children: [
          Column(children: [
            RaisedButton(
                child: Text('Detalle'),
                onPressed: () => product.toData().forEach((key, value) {
                      print('key $key value $value');
                    })),
            Text(product.productName),
            Text('Marca: ${product.brands}'),
            Image(
                image: NetworkImage(productImages
                    .firstWhere((image) => image.field == ImageField.FRONT)
                    .url)),
            Text('Valores por 100g'),
            Text('Energía: ${nutriments.energyKcal100g} g'),
            Text('Grasas: ${nutriments.fat} g'),
            Text('Grasas saturadas: ${nutriments.saturatedFat} g'),
            Text('Hidratos de carbono: ${nutriments.carbohydrates} g'),
            Text('Azúcares: ${nutriments.sugars} g'),
            Text('Fibra: ${nutriments.fiber} g'),
            Text('Proteínas: ${nutriments.proteins} g'),
            Text('Sal: ${nutriments.salt} g'),
            Text('Nutriscore: ${product.nutriscore.toUpperCase()}'),
            Text('NovaGroup: ${nutriments.novaGroup}'),
            Text(
                '${RecommendedDailyIntake.getRecommendedDailyIntakes().sugars.value}')
          ]),
          Column(
            children: [
              Text('Nutrition Levels: '),
              for (var level in levels)
                Text(
                  '${level.key}: ${level.value.value} ',
                )
            ],
          ),
          Column(
            children: [
              Text('Aditivos: '),
              for (var additive in product.additives.names)
                Text(
                  '$additive ',
                )
            ],
          ),
          Column(
            children: [
              Text('Alérgenos: '),
              for (var allergen in product.allergens.names)
                Text(
                  '$allergen ',
                )
            ],
          ),
          Column(
            children: [
              Text('Contiene trazas de: '),
              for (var tag in product.tracesTags)
                Text(
                  '${tag.substring(3)} ',
                )
            ],
          ),
          Column(
            children: [
              Text('Análisis Tags: '),
              Text(
                'Vegano: $isVegan ',
              ),
              Text(
                'Vegetariano: $isVegetarian ',
              ),
              Text(
                'Aceite de Palma: $isPalmOilFree ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
