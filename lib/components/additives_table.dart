import 'package:flutter/material.dart';

class AdditivesTable extends StatelessWidget {
  AdditivesTable(
      {@required this.additives, @required this.additivesTranslated});

  final List<String> additives;
  final Map<String, dynamic> additivesTranslated;

  @override
  Widget build(BuildContext context) {
    String riskLevel(String additive) => additivesTranslated[additive] != null
        ? additivesTranslated[additive]['overexposure_risk']
        : '';

    String nameTranslated(String additive) =>
        additivesTranslated[additive] != null
            ? additivesTranslated[additive]['name']
            : additive;

    Color color(String risk) {
      if (risk == 'Riesgo alto') return Colors.red[900];
      if (risk == 'Riesgo medio') return Colors.orange[900];
      if (risk == 'Riesgo bajo') return Colors.green[900];
      return Colors.grey[900];
    }

    return Column(children: [
      const Text('Aditivos: '),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                'Nombre',
                textAlign: TextAlign.center,
              )),
          const Flexible(
              fit: FlexFit.tight,
              child: Text(
                'Riesgo exposición',
                textAlign: TextAlign.center,
              )),
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      for (var additive in additives)
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Container(
                color: color(riskLevel(additive)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    nameTranslated(additive),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                color: color(riskLevel(additive)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    riskLevel(additive),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 5.0,
          )
        ]),
    ]);
  }
}
