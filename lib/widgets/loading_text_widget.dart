import 'package:flutter/material.dart';

class LoadingTextWidget extends StatelessWidget {
  final String text1;
  final String text2;

  const LoadingTextWidget({
    @required this.text1,
    @required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          text1,
          style: TextStyle(
            fontSize: 32.0,
            color: Colors.black54,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
