import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/utils/NutrimentsHelper.dart';
import 'package:smart_count_calories/components/item_nutrition.dart';

class Nutrition extends StatelessWidget {
  const Nutrition({
    @required this.nutriments,
    @required this.gramos,
  });

  final Nutriments nutriments;
  final double gramos;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 6,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 3,
        childAspectRatio: 20 / 16,
        shrinkWrap: true,
        children: [
          ItemNutrition(
            topNameLine1: 'Energía',
            bottomName: 'calorias',
            value: (NutrimentsHelper.getEnergyAsKCal(nutriments) * gramos / 100)
                .toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Grasas',
            value: ((nutriments.fat ?? 0) * gramos / 100).toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Grasas',
            topNameLine2: 'saturadas',
            value: ((nutriments.saturatedFat ?? 0) * gramos / 100)
                .toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Hidratos de',
            topNameLine2: 'carbono',
            value: ((nutriments.carbohydrates ?? 0) * gramos / 100)
                .toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Azúcares',
            value: ((nutriments.sugars ?? 0) * gramos / 100).toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Fibra',
            value: ((nutriments.fiber ?? 0) * gramos / 100).toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Proteínas',
            value:
                ((nutriments.proteins ?? 0) * gramos / 100).toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Sal',
            value: ((nutriments.salt ?? 0) * gramos / 100).toStringAsFixed(2),
          ),
          ItemNutrition(
            topNameLine1: 'Sodio',
            value: ((nutriments.salt ?? 0) * gramos / 100 * 0.4)
                .toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}
