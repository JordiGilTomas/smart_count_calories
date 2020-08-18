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
  bool showFloatButton = true;

  @override
  void initState() {
    super.initState();
    textEditingController.text = '100 gramos';
  }

  @override
  Widget build(BuildContext context) {
    List<ProductImage> productImages = widget.product.selectedImages;
    Nutriments nutriments = widget.product.nutriments;
    Iterable<MapEntry<String, Level>> levels =
        widget.product.nutrientLevels.levels.entries;
    Map<String, dynamic> productJson = widget.product.toJson();
    String isVegan =
        productJson['ingredients_analysis_tags'][0].toString().substring(3);
    String isVegetarian =
        productJson['ingredients_analysis_tags'][1].toString().substring(3);
    String isPalmOilFree =
        productJson['ingredients_analysis_tags'][2].toString().substring(3);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text('Smart Count Calories'),
        ),
        body: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Column(
            children: [
              Expanded(
                child: Scaffold(
                  floatingActionButton: showFloatButton
                      ? FloatingActionButton.extended(
                          icon: Icon(Icons.add),
                          onPressed: () => null,
                          label: Text(
                            'Añadir producto',
                          ),
                        )
                      : null,
                  appBar: AppBar(
                    leading: Padding(
                      padding: EdgeInsets.all(10.0),
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
                      text: TextSpan(
                        children: [
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
                              : TextSpan(),
                        ],
                      ),
                    ),
                    centerTitle: true,
                    elevation: 10.0,
                    bottom: TabBar(
                      labelPadding: EdgeInsets.all(5.0),
                      labelStyle: TextStyle(fontSize: 18.0),
                      tabs: <Widget>[
                        Text('Nutricional'),
                        Text('Puntuación'),
                        Text('Aditivos'),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Column(
                        children: [
                          Flexible(
                            flex: 6,
                            child: Nutrition(
                                nutriments: nutriments, gramos: gramos),
                          ),
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                      controller: textEditingController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      onTap: () {
                                        setState(() {
                                          textEditingController.text =
                                              textEditingController.text
                                                  .split('gramos')[1];
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
                                            '${gramos.toInt()}  gramos';
                                        setState(() {
                                          showFloatButton = true;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Slider(
                              value: gramos,
                              max: 500.0,
                              min: 0.0,
                              divisions: 500,
                              onChanged: (double newValue) {
                                setState(
                                  () {
                                    gramos = newValue;
                                    textEditingController.text =
                                        '${newValue.toInt()} gramos';
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Score(
                          nutriscore: widget.product.nutriscore,
                          nutriments: nutriments,
                          levels: levels,
                          isVegan: isVegan,
                          isVegetarian: isVegetarian,
                          isPalmOilFree: isPalmOilFree),
                      ListView(
                        children: [
                          Column(
                            children: [
                              Text('Aditivos: '),
                              for (var additive
                                  in widget.product.additives.names)
                                Text(
                                  '$additive ',
                                ),
                              Text('Alérgenos: '),
                              for (var allergen
                                  in widget.product.allergens.names)
                                Text(
                                  '$allergen ',
                                ),
                              Text('Contiene trazas de: '),
                              for (var tag in widget.product.tracesTags)
                                Text(
                                  '${tag.substring(3)} ',
                                ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
