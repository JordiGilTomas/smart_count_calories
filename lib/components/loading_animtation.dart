import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 10.0,
        ),
        Text('Loading data, please wait...')
      ]),
    );
  }
}
