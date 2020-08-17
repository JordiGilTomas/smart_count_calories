import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smart_count_calories/components/nutrition.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                                    onSubmitted: (value) =>
                                        textEditingController.text =
                                            '${gramos.toInt()}  gramos',
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
                          Container(
                            height: 150.0,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (widget.product.nutriscore != null)
                                    SvgPicture.asset(
                                      'images/nutriscore_${widget.product.nutriscore}.svg',
                                      height: 100.0,
                                    ),
                                  if (nutriments.novaGroup != null)
                                    Container(
                                      color: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 10.0)),
                                        child: SvgPicture.asset(
                                          'images/nova_${nutriments.novaGroup}.svg',
                                          height: 80.0,
                                        ),
                                      ),
                                    )
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Card(
                                // color: Colors.blueGrey[700],
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Expanded(
                                            child: Container(
                                              // color: Colors.blueGrey[900],
                                              color: Theme.of(context)
                                                  .primaryColorDark,

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
                                      ],
                                    ),
                                    for (var level in levels)
                                      Column(children: [
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                                    color: level.value.value ==
                                                            'low'
                                                        ? Colors.green[Theme.of(
                                                                        context)
                                                                    .brightness
                                                                    .toString() ==
                                                                'Brightness.dark'
                                                            ? 200
                                                            : 800]
                                                        : level.value.value ==
                                                                'moderate'
                                                            ? Colors.orange[800]
                                                            : Colors.red[800],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ]),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (isVegan == 'vegan')
                                  SvgPicture.asset(
                                    'images/vegan.svg',
                                    height: 80.0,
                                  ),
                                if (isVegetarian == 'vegetarian')
                                  SvgPicture.asset(
                                    'images/vegetarian.svg',
                                    height: 85.0,
                                  ),
                                if (isPalmOilFree == 'palm-oil-free')
                                  SvgPicture.asset(
                                    'images/palm-oil-free.svg',
                                    height: 70.0,
                                  ),
                              ]),
                        ])
                      ]),
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
