import 'package:flutter/material.dart';

class ItemNutrition extends StatelessWidget {
  const ItemNutrition({
    @required this.topNameLine1,
    this.topNameLine2,
    this.bottomName = "gramos",
    @required this.value,
  });

  final String topNameLine1;
  final String topNameLine2;
  final String bottomName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(children: [
            topNameLine2 != null
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: '$topNameLine1\n',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.button.color),
                        children: [TextSpan(text: '$topNameLine2')]),
                  )
                : Text(topNameLine1),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$value',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(bottomName),
          ]),
        ),
      ),
    );
  }
}
