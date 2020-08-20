import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagsLogos extends StatelessWidget {
  const TagsLogos({
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.isPalmOilFree,
  });

  final bool isVegan;
  final bool isVegetarian;
  final bool isPalmOilFree;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      if (isVegan)
        SvgPicture.asset(
          'images/vegan.svg',
          height: 80.0,
        ),
      if (isVegetarian)
        SvgPicture.asset(
          'images/vegetarian.svg',
          height: 85.0,
        ),
      if (isPalmOilFree)
        SvgPicture.asset(
          'images/palm-oil-free.svg',
          height: 70.0,
        ),
    ]);
  }
}
