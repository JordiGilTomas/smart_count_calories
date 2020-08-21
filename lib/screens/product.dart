import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../components/additives_table.dart';
import '../components/loading_animation.dart';
import '../components/nutrition.dart';
import '../components/score.dart';
import '../model/additive.dart';
import '../model/allergen.dart';
import '../model/equivalent_measures.dart';

class ProductCard extends StatefulWidget {
  ProductCard({this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final TextEditingController textEditingController = TextEditingController();
  bool isLoading = true;
  double defaultQuantity = 500.0;
  double maxQuantity = 500.0;
  double quantity = 100.0;
  String selectedMeasure = 'gramos';
  Map<String, dynamic> additivesTraductions;
  Map<String, dynamic> allergensTraductions;

  Future<void> loadData() async {
    additivesTraductions = await Additive.fromJson();
    allergensTraductions = await Allergen.fromJson();
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = '100 gramos';

    loadData().whenComplete(() {
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

    String allergenNameTranslated(String allergen) =>
        allergensTraductions[allergen]['name'];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.black,
          activeColor: Colors.blueAccent,
          style: TabStyle.fixedCircle,
          color: Colors.blue,

          items: [
            TabItem(
              title: 'Home',
              icon: Icon(Icons.home),
            ),
            TabItem(
              title: 'Home',
              icon: Icon(Icons.home),
            ),
            TabItem(
              title: 'Añadir',
              isIconBlend: true,
              icon: Icon(Icons.add, size: 40.0),
            ),
            TabItem(
              title: 'Home',
              icon: Icon(Icons.home),
            ),
            TabItem(
              title: 'Home',
              icon: Icon(Icons.home),
            ),
          ],
          initialActiveIndex: 2, //optional, default as 0
          onTap: (int i) => print('click index=$i'),
        ),
        body: isLoading
            ? const LoadingWidget()
            : DefaultTabController(
                length: 3,
                initialIndex: 1,
                child: Column(children: [
                  Expanded(
                    child: Scaffold(
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
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 9,
                                child: Nutrition(
                                  nutriments: nutriments,
                                  quantity: quantity,
                                  measureFactor: EquivalentMeasures.toMap()[
                                      selectedMeasure],
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Row(children: [
                                    PopupMenuButton(
                                        onSelected: (String measure) =>
                                            setState(() {
                                              selectedMeasure = measure;
                                              maxQuantity = EquivalentMeasures
                                                              .toMap()[
                                                          selectedMeasure] ==
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
                                    Flexible(
                                      child: TextField(
                                          decoration:
                                              InputDecoration(isDense: true),
                                          controller: textEditingController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          onTap: () {
                                            setState(() {
                                              textEditingController.text =
                                                  textEditingController.text
                                                      .split(
                                                          '$selectedMeasure')[1];
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              try {
                                                if (int.parse(value) >
                                                    maxQuantity) {
                                                  textEditingController.text =
                                                      '$maxQuantity';
                                                  value = '$maxQuantity';
                                                }
                                                if (int.parse(value) < 0) {
                                                  textEditingController.text =
                                                      '0';
                                                  value = '0';
                                                }
                                                quantity = double.parse(value);
                                              } catch (_) {}
                                            });
                                          },
                                          onSubmitted: (value) {
                                            textEditingController.text =
                                                '${quantity.toInt()}  $selectedMeasure';
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
                              ),
                              SizedBox(
                                height: 15.0,
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
                              ),
                              SizedBox(
                                height: 35.0,
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
                              AdditivesTable(
                                  additives: widget.product.additives.names,
                                  additivesTranslated: additivesTraductions),
                              const Text('Alérgenos: '),
                              for (var allergen
                                  in widget.product.allergens.names)
                                Text(allergenNameTranslated(allergen)),
                              const Text('Contiene trazas de: '),
                              for (var tag in widget.product.tracesTags)
                                Text(
                                  allergenNameTranslated(tag.substring(3)),
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
