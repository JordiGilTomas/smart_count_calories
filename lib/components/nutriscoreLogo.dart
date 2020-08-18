import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NutriscoreLogo extends StatelessWidget {
  NutriscoreLogo({this.nutriscore});

  final String nutriscore;

  @override
  Widget build(BuildContext context) {
    return nutriscore != null
        ? SvgPicture.asset('images/nutriscore_$nutriscore.svg', height: 100.0)
        : Container();
  }
}
