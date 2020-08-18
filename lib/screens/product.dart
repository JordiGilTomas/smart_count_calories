import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smart_count_calories/components/nutrition.dart';
import 'package:smart_count_calories/components/score.dart';

class ProductCard extends StatefulWidget {
  ProductCard({this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double gramos = 100.0;

  final textEditingController = TextEditingController();
  String selectedMeasure = 'gramos';
  bool showFloatButton = true;

  @override
  void initState() {
    super.initState();
    textEditingController.text = '100 gramos';
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductImage> productImages = widget.product.selectedImages;
    final Nutriments nutriments = widget.product.nutriments;
    final Iterable<MapEntry<String, Level>> levels =
        widget.product.nutrientLevels.levels.entries;
    final Map<String, dynamic> productJson = widget.product.toJson();
    final String isVegan =
        productJson['ingredients_analysis_tags'][0].toString().substring(3);
    final String isVegetarian =
        productJson['ingredients_analysis_tags'][1].toString().substring(3);
    final String isPalmOilFree =
        productJson['ingredients_analysis_tags'][2].toString().substring(3);

    final Map<String, double> equivalentMeasures = {
      'gramos': 1.0,
      'ml': 1.0,
      'taza desayuno': 2.5,
      'taza té': 1.5,
      'taza café': 1,
      'cuchara sopera': 0.15,
      'cuchara postre': 0.10,
      'cuchara café': 0.05,
      'vaso agua': 2.5,
      'vasito vino': 1,
      'vasito licor': 0.50
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: const Text('Smart Count Calories'),
        ),
        body: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Column(children: [
            Expanded(
              child: Scaffold(
                floatingActionButton: showFloatButton
                    ? FloatingActionButton.extended(
                        icon: const Icon(Icons.add),
                        onPressed: () => null,
                        label: const Text('Añadir producto'),
                      )
                    : null,
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        productImages
                            .firstWhere((image) =>
                                image.size == ImageSize.THUMB &&
                                image.field == ImageField.FRONT)
                            .url,
                      ),
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: widget.product.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      widget.product.brands != ''
                          ? TextSpan(
                              text: '\n(${widget.product.brands})',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color),
                            )
                          : const TextSpan(),
                    ]),
                  ),
                  centerTitle: true,
                  elevation: 10.0,
                  bottom: const TabBar(
                    labelPadding: EdgeInsets.all(5.0),
                    labelStyle: TextStyle(fontSize: 18.0),
                    tabs: <Widget>[
                      Text('Nutricional'),
                      Text('Puntuación'),
                      Text('Aditivos'),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  Column(children: [
                    Flexible(
                      flex: 7,
                      child: Nutrition(
                        nutriments: nutriments,
                        quantity: gramos,
                        measureFactor: equivalentMeasures[selectedMeasure],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(children: [
                        PopupMenuButton(
                            onSelected: (String measure) => setState(() {
                                  selectedMeasure = measure;
                                  textEditingController.text =
                                      '${gramos.toInt()} $selectedMeasure';
                                }),
                            itemBuilder: (context) => equivalentMeasures.keys
                                .map((measure) => PopupMenuItem(
                                      child: Text('$measure'),
                                      value: measure,
                                    ))
                                .toList()),
                        Expanded(
                          child: TextField(
                              decoration: InputDecoration(isDense: true),
                              controller: textEditingController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                setState(() {
                                  textEditingController.text =
                                      textEditingController.text
                                          .split('$selectedMeasure')[1];
                                  showFloatButton = false;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (int.parse(value) > 500) {
                                    textEditingController.text = '500';
                                    value = '500';
                                  }
                                  gramos = double.parse(value);
                                });
                              },
                              onSubmitted: (value) {
                                textEditingController.text =
                                    '${gramos.toInt()}  $selectedMeasure';
                                setState(() {
                                  showFloatButton = true;
                                });
                              }),
                        ),
                        RaisedButton(
                          onPressed: () => {},
                          child: Text('Ración'),
                        )
                      ]),
                    ),
                    Flexible(
                      flex: 1,
                      child: Slider(
                          value: gramos,
                          max: 500.0,
                          min: 0.0,
                          divisions: 500,
                          onChanged: (double newValue) {
                            setState(() {
                              gramos = newValue;
                              textEditingController.text =
                                  '${newValue.toInt()} $selectedMeasure';
                            });
                          }),
                    )
                  ]),
                  Score(
                      nutriscore: widget.product.nutriscore,
                      nutriments: nutriments,
                      levels: levels,
                      isVegan: isVegan,
                      isVegetarian: isVegetarian,
                      isPalmOilFree: isPalmOilFree),
                  ListView(children: [
                    Column(children: [
                      const Text('Aditivos: '),
                      for (var additive in widget.product.additives.names)
                        Text('$additive '),
                      const Text('Alérgenos: '),
                      for (var allergen in widget.product.allergens.names)
                        Text('$allergen '),
                      const Text('Contiene trazas de: '),
                      for (var tag in widget.product.tracesTags)
                        Text(
                          '${tag.substring(3)} ',
                        ),
                    ])
                  ]),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
