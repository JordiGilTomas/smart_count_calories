import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/RecommendedDailyIntake.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smart_count_calories/components/nutrition.dart';

class ProductCard extends StatefulWidget {
  ProductCard({this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double gramos = 100.0;

  final textEditingController = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
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
                floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  onPressed: () => null,
                  label: Text(
                    'Añadir producto',
                  ),
                ),
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
                  backgroundColor: Colors.deepPurple,
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.product.productName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        widget.product.brands != ''
                            ? TextSpan(text: '\n(${widget.product.brands})')
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
                        Nutrition(nutriments: nutriments, gramos: gramos),
                        Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 4,
                                child: TextField(
                                  controller: textEditingController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onTap: () {
                                    setState(() {
                                      textEditingController.text =
                                          textEditingController.text
                                              .split('gramos')[1];
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
                                  onSubmitted: (value) => textEditingController
                                      .text = '${gramos.toInt()}  gramos',
                                ),
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
                            // label: '${gramos.floor()} gramos',
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
                    ListView(children: [
                      Column(children: [
                        Text(
                            'Nutriscore: ${widget.product.nutriscore?.toUpperCase()}'),
                        Text('NovaGroup: ${nutriments.novaGroup}'),
                        Text(
                            'Sugan Intake: ${RecommendedDailyIntake.getRecommendedDailyIntakes().sugars.value} gr'),
                        Text('Nutrition Levels: '),
                        for (var level in levels)
                          Text(
                            '${level.key}: ${level.value.value} ',
                          ),
                        Text('Análisis Tags: '),
                        Text(
                          'Vegano: $isVegan ',
                        ),
                        Text(
                          'Vegetariano: $isVegetarian ',
                        ),
                        Text(
                          'Aceite de Palma: $isPalmOilFree ',
                        ),
                      ])
                    ]),
                    ListView(
                      children: [
                        Column(
                          children: [
                            Text('Aditivos: '),
                            for (var additive in widget.product.additives.names)
                              Text(
                                '$additive ',
                              ),
                            Text('Alérgenos: '),
                            for (var allergen in widget.product.allergens.names)
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
    );
  }
}
