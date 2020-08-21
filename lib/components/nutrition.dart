import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/utils/NutrimentsHelper.dart';
import 'package:smart_count_calories/components/item_nutrition.dart';

class Nutrition extends StatelessWidget {
  const Nutrition(
      {@required this.nutriments,
      @required this.quantity,
      @required this.measureFactor});

  final Nutriments nutriments;
  final double quantity;
  final double measureFactor;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 3,
      childAspectRatio: 20 / 17,
      shrinkWrap: false,
      children: [
        ItemNutrition(
          topNameLine1: 'Energía',
          bottomName: 'calorías',
          value: (NutrimentsHelper.getEnergyAsKCal(nutriments) *
                  quantity /
                  100 *
                  measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Grasas',
          value: ((nutriments.fat ?? 0) * quantity / 100 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Grasas',
          topNameLine2: 'saturadas',
          value:
              ((nutriments.saturatedFat ?? 0) * quantity / 100 * measureFactor)
                  .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Hidratos de',
          topNameLine2: 'carbono',
          value:
              ((nutriments.carbohydrates ?? 0) * quantity / 100 * measureFactor)
                  .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Azúcares',
          value: ((nutriments.sugars ?? 0) * quantity / 100 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Fibra',
          value: ((nutriments.fiber ?? 0) * quantity / 100 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Proteínas',
          value: ((nutriments.proteins ?? 0) * quantity / 100 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Sal',
          value: ((nutriments.salt ?? 0) * quantity / 100 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Sodio',
          value: ((nutriments.salt ?? 0) * quantity / 100 * 0.4 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Sal',
          value: ((nutriments.salt ?? 0) * quantity / 100 * measureFactor)
              .toStringAsFixed(2),
        ),
        ItemNutrition(
          topNameLine1: 'Sodio',
          value: ((nutriments.salt ?? 0) * quantity / 100 * 0.4 * measureFactor)
              .toStringAsFixed(2),
        ),
      ],
    );
  }
}
