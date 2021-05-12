import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator {
  static customLoadingIndicator(double size) {
    return SpinKitPouringHourglass(
      color: Colors.deepOrangeAccent,
      size: size,
    );
  }
}
