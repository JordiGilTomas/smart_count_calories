import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';

class NutritionLevels extends StatelessWidget {
  const NutritionLevels({
    @required this.levels,
  });

  final Iterable<MapEntry<String, Level>> levels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Expanded(
                    child: Container(
                      color: Theme.of(context).primaryColorDark,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Nutrition Levels',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .color),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
              for (var level in levels)
                Column(children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            '${level.key.toUpperCase()}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            '${level.value.value.toUpperCase()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: level.value.value == 'low'
                                    ? Colors.green[Theme.of(context)
                                                .brightness
                                                .toString() ==
                                            'Brightness.dark'
                                        ? 200
                                        : 800]
                                    : level.value.value == 'moderate'
                                        ? Colors.orange[Theme.of(context)
                                                    .brightness
                                                    .toString() ==
                                                'Brightness.dark'
                                            ? 200
                                            : 800]
                                        : Colors.red[Theme.of(context)
                                                    .brightness
                                                    .toString() ==
                                                'Brightness.dark'
                                            ? 200
                                            : 800],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 5.0,
                  ),
                ]),
            ]),
          ),
        ),
      ),
    );
  }
}
