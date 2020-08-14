import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/RecommendedDailyIntake.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    List<ProductImage> productImages = product.selectedImages;
    Nutriments nutriments = product.nutriments;
    Iterable<MapEntry<String, Level>> levels =
        product.nutrientLevels.levels.entries;
    Map<String, dynamic> productJson = product.toJson();
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
        child:

            // Column(children: [
            //   Text(product.productName),
            //   Text('Marca: ${product.brands}'),
            //   Image(
            //       image: NetworkImage(productImages
            //           .firstWhere((image) => image.field == ImageField.FRONT)
            //           .url)),
            // ]),

            Column(children: [
          // Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Image(
          //       image: NetworkImage(productImages
          //           .firstWhere((image) => image.field == ImageField.FRONT)
          //           .url)),
          // ),

          Expanded(
            child: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  onPressed: null,
                  label: Text(
                    'Add product',
                  )),
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
                        text: product.productName,
                        // style: TextStyle(fontSize: 20.0),
                      ),
                      TextSpan(text: '\n(${product.brands})')
                    ],
                  ),
                ),
                centerTitle: true,
                elevation: 10.0,
                // backgroundColor: Colors.deepPurple,
                bottom: TabBar(
                  tabs: <Widget>[
                    Text('Nutricional'),
                    Text('Scores'),
                    Text('Aditivos'),
                  ],
                  // labelStyle: TextStyle(fontSize: 20.0),
                ),
              ),
              body: TabBarView(children: [
                ListView(children: [
                  Column(children: [
                    Text('Valores por 100g'),
                    Text('Energía: ${nutriments.energyKcal100g} g'),
                    Text('Grasas: ${nutriments.fat} g'),
                    Text('Grasas saturadas: ${nutriments.saturatedFat} g'),
                    Text('Hidratos de carbono: ${nutriments.carbohydrates} g'),
                    Text('Azúcares: ${nutriments.sugars} g'),
                    Text('Fibra: ${nutriments.fiber} g'),
                    Text('Proteínas: ${nutriments.proteins} g'),
                    Text('Sal: ${nutriments.salt} g'),
                  ])
                ]),
                ListView(children: [
                  Column(children: [
                    Text('Nutriscore: ${product.nutriscore.toUpperCase()}'),
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
                ListView(children: [
                  Column(children: [
                    Text('Aditivos: '),
                    for (var additive in product.additives.names)
                      Text(
                        '$additive ',
                      ),
                    Text('Alérgenos: '),
                    for (var allergen in product.allergens.names)
                      Text(
                        '$allergen ',
                      ),
                    Text('Contiene trazas de: '),
                    for (var tag in product.tracesTags)
                      Text(
                        '${tag.substring(3)} ',
                      ),
                  ])
                ]),
              ]),
            ),
          ),
          // RaisedButton(
          //     child: Text('Añadir a comida'),
          //     onPressed: () => product.toData().forEach((key, value) {
          //           print('key $key value $value');
          //         })),
        ]),
      ),
    );
  }
}
