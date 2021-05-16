import 'package:flutter/material.dart';
import 'custom_loading_indicator.dart';
import 'loading_text_widget.dart';

class LoadingWidget extends StatelessWidget {
  final String text1;
  final String text2;

  const LoadingWidget({@required this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomLoadingIndicator.customLoadingIndicator(100),
            LoadingTextWidget(
              text1: "Fetching Restaurants",
              text2: "Please Wait...",
            ),
          ],
        ),
      ),
    );
  }
}
