import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smart_count_calories/components/loading_animtation.dart';
import 'package:smart_count_calories/components/nutrition.dart';
import 'package:smart_count_calories/components/score.dart';
import 'package:smart_count_calories/model/additive.dart';
import 'package:smart_count_calories/model/equivalent_measures.dart';

class ProductCard extends StatefulWidget {
  ProductCard({this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double quantity = 100.0;

  final textEditingController = TextEditingController();
  String selectedMeasure = 'gramos';
  bool showFloatButton = true;
  double maxQuantity = 500.0;
  double defaultQuantity = 500.0;
  Map<String, dynamic> additives;
  bool isLoading = true;

  Future<void> loadAdditiveData() async =>
      additives = await Additive.fromJson();

  @override
  void initState() {
    super.initState();
    textEditingController.text = '100 gramos';

    loadAdditiveData().whenComplete(() {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductImage> productImages = widget.product.selectedImages;
    final Nutriments nutriments = widget.product.nutriments;
    final Iterable<MapEntry<String, Level>> levels =
        widget.product.nutrientLevels.levels.entries;
    final Map<String, dynamic> productJson = widget.product.toJson();
    final bool isVegan =
        productJson['ingredients_analysis_tags'][0].toString().substring(3) ==
            'vegan';
    final bool isVegetarian =
        productJson['ingredients_analysis_tags'][1].toString().substring(3) ==
            'vegetarian';
    final bool isPalmOilFree =
        productJson['ingredients_analysis_tags'][2].toString().substring(3) ==
            'palm-oil-free';

    final Map<String, dynamic> servingMeasure =
        widget.product.servingSize != null
            ? RegExp(r'([\d]+)([a-z]+)')
                .allMatches(widget.product.servingSize)
                .map<Map<String, dynamic>>(
                    (match) => {'quantity': match[1], 'measure': match[2]})
                .toList()[0]
            : null;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: const Text('Smart Count Calories'),
        ),
        body: isLoading
            ? LoadingWidget()
            : DefaultTabController(
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
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color),
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
                              quantity: quantity,
                              measureFactor:
                                  EquivalentMeasures.toMap()[selectedMeasure],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Row(children: [
                              PopupMenuButton(
                                  onSelected: (String measure) => setState(() {
                                        selectedMeasure = measure;
                                        maxQuantity = EquivalentMeasures
                                                    .toMap()[selectedMeasure] ==
                                                1.0
                                            ? defaultQuantity
                                            : defaultQuantity / 10;
                                        quantity = maxQuantity / 2;
                                        textEditingController.text =
                                            '${quantity.toInt()} $selectedMeasure';
                                      }),
                                  itemBuilder: (context) =>
                                      EquivalentMeasures.toMap()
                                          .keys
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
                                        try {
                                          if (int.parse(value) > maxQuantity) {
                                            textEditingController.text =
                                                '$maxQuantity';
                                            value = '$maxQuantity';
                                          }
                                          if (int.parse(value) < 0) {
                                            textEditingController.text = '0';
                                            value = '0';
                                          }
                                          quantity = double.parse(value);
                                        } catch (_) {}
                                      });
                                    },
                                    onSubmitted: (value) {
                                      textEditingController.text =
                                          '${quantity.toInt()}  $selectedMeasure';
                                      setState(() {
                                        showFloatButton = true;
                                      });
                                    }),
                              ),
                              RaisedButton(
                                onPressed: servingMeasure != null
                                    ? () => setState(() => {
                                          maxQuantity = defaultQuantity,
                                          selectedMeasure =
                                              servingMeasure['measure'],
                                          quantity = double.parse(
                                              servingMeasure['quantity']),
                                          textEditingController.text =
                                              '${quantity.toInt()} $selectedMeasure',
                                        })
                                    : null,
                                child: Text('Ración'),
                              )
                            ]),
                          ),
                          Flexible(
                            flex: 1,
                            child: Slider(
                                value: quantity,
                                max: maxQuantity,
                                min: 0.0,
                                divisions: maxQuantity.toInt(),
                                onChanged: (double newValue) {
                                  setState(() {
                                    quantity = newValue;
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
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              const Text('Aditivos: '),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'Nombre',
                                        textAlign: TextAlign.center,
                                      )),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        'Riesgo exposición',
                                        textAlign: TextAlign.center,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              for (var additive
                                  in widget.product.additives.names)
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(
                                          '${additives[additive] != null ? additives[additive]['name'] : additive}',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(
                                          '${additives[additive] != null ? additives[additive]['overexposure_risk'] : ''}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                              const Text('Alérgenos: '),
                              for (var allergen
                                  in widget.product.allergens.names)
                                Text('$allergen '),
                              const Text('Contiene trazas de: '),
                              for (var tag in widget.product.tracesTags)
                                Text(
                                  '${tag.substring(3)} ',
                                ),
                            ]),
                          )
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
