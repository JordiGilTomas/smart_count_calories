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
                          'Valores nutricionales',
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
                            tagText(level.key),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            tagLevel(level.value.value),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: tagColor(
                                    tag: level.value.value, context: context),
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

  String tagText(String tag) {
    switch (tag) {
      case 'sugars':
        return 'Azúcares';
        break;
      case 'fat':
        return 'Grasas';
        break;
      case 'saturated-fat':
        return 'Grasas saturadas';
        break;
      default:
        return 'Sal';
    }
  }

  String tagLevel(String tag) {
    switch (tag) {
      case 'high':
        return 'Cantidad elevada';
        break;
      case 'medium':
        return 'Cantidad moderada';
        break;
      default:
        return 'Cantidad baja';
    }
  }

  Color tagColor({String tag, BuildContext context}) {
    switch (tag) {
      case 'high':
        return Colors.red[calculateBrightness(context)];
        break;
      case 'medium':
        return Colors.orange[calculateBrightness(context)];
        break;
      default:
        return Colors.green[calculateBrightness(context)];
    }
  }

  int calculateBrightness(BuildContext context) {
    return Theme.of(context).brightness.toString() == 'Brightness.dark'
        ? 200
        : 800;
  }
}
