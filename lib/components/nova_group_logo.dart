import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NovaGroupLogo extends StatelessWidget {
  NovaGroupLogo({this.novaGroup});

  final int novaGroup;

  @override
  Widget build(BuildContext context) {
    return novaGroup != null
        ? Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 10.0),
              ),
              child: SvgPicture.asset(
                'images/nova_$novaGroup.svg',
                height: 80.0,
              ),
            ),
          )
        : Container();
  }
}
