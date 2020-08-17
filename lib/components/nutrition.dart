import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/utils/NutrimentsHelper.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.grey[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Energía'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${(NutrimentsHelper.getEnergyAsKCal(nutriments) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('calorías'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.green[700].withOpacity(1),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Grasas'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.fat ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.deepOrange[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Grasas\n',
                        children: [TextSpan(text: 'saturadas')]),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.saturatedFat ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.orangeAccent[700].withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Hidratos de\n',
                        children: [TextSpan(text: 'carbono')]),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.carbohydrates ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.deepOrange[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Azúcares'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.sugars ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.deepOrange[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Fibra'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.fiber ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.deepOrange[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Proteinas'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.proteins ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.deepOrange[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Sal'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.salt ?? 0) * gramos / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.deepOrange[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(children: [
                  Text('Sodio'),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${((nutriments.salt ?? 0) * gramos / 100 * 0.4).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text('gramos'),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
