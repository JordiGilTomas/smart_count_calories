import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagsLogos extends StatelessWidget {
  const TagsLogos({
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.isPalmOilFree,
  });

  final String isVegan;
  final String isVegetarian;
  final String isPalmOilFree;

  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
