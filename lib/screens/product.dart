import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/RecommendedDailyIntake.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

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
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
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
                        Flexible(
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Energía'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${(NutrimentsHelper.getEnergyAsKCal(nutriments) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Grasas'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.fat ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: 'Grasas\n',
                                            children: [
                                              TextSpan(text: 'saturadas')
                                            ]),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.saturatedFat ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                  color:
                                      Colors.orangeAccent[700].withOpacity(0.8),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: 'Hidratos de\n',
                                            children: [
                                              TextSpan(text: 'carbono')
                                            ]),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.carbohydrates ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Azúcares'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.sugars ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Fibra'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.fiber ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Proteinas'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.proteins ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Sal'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.salt ?? 0) * gramos / 100).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(children: [
                                      Text('Sodio'),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${((nutriments.salt ?? 0) * gramos / 100 * 0.4).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
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
                        ),
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
