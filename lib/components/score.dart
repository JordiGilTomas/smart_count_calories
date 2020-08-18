import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:smart_count_calories/components/nova_group_logo.dart';
import 'package:smart_count_calories/components/nutriscoreLogo.dart';
import 'package:smart_count_calories/components/nutrition_levels.dart';
import 'package:smart_count_calories/components/tags_logos.dart';

class Score extends StatelessWidget {
  const Score(
      {@required this.nutriments,
      @required this.levels,
      @required this.isVegan,
      @required this.isVegetarian,
      @required this.isPalmOilFree,
      @required this.nutriscore});

  final Nutriments nutriments;
  final Iterable<MapEntry<String, Level>> levels;
  final String isVegan;
  final String isVegetarian;
  final String isPalmOilFree;
  final String nutriscore;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(children: [
        Container(
          height: 150.0,
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment:
                nutriscore == null || nutriments.novaGroup == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround,
            children: [
              NutriscoreLogo(nutriscore: nutriscore),
              NovaGroupLogo(novaGroup: nutriments.novaGroup),
            ],
          ),
        ),
        NutritionLevels(levels: levels),
        TagsLogos(
            isVegan: isVegan,
            isVegetarian: isVegetarian,
            isPalmOilFree: isPalmOilFree),
        SizedBox(
          height: 75.0,
        )
      ])
    ]);
  }
}
