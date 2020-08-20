import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/services.dart';

class Additive {
  static String _riskMessage(String value) {
    if (value == 'en:high') return 'Riesgo alto';
    if (value == 'en:medium') return 'Riesgo medio';
    if (value == 'en:low') return 'Riesgo bajo';
    return '';
  }

  static Future<Map<String, dynamic>> fromJson() async {
    Response response = await get(
        'https://static.openfoodfacts.org/data/taxonomies/additives.json');

    Map<String, dynamic> data = await json.decode(response.statusCode != 200
        ? await rootBundle.loadString('lib/model/additives.json')
        : Utf8Decoder().convert(response.bodyBytes));

    return data.map<String, dynamic>((key, value) =>
        MapEntry<String, dynamic>(key.toUpperCase().substring(3), {
          'name': value['name']['es'],
          'wikidata': value['wikidata'] != null
              ? 'https://www.wikidata.org/wiki/wikidata/${value['wikidata']['en'] ?? null}'
              : null,
          'overexposure_risk': value['efsa_evaluation_overexposure_risk'] !=
                  null
              ? _riskMessage(value['efsa_evaluation_overexposure_risk']['en'])
              : ''
        }));
  }
}
