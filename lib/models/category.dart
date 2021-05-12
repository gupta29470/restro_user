import 'package:flutter/foundation.dart';

class Category {
  final String categoryName;
  final String categoryImage;
  final String restroName;
  final List<dynamic> categoryNames;
  final List<dynamic> categoryImages;

  Category({
    @required this.categoryName,
    @required this.categoryImage,
    @required this.restroName,
    @required this.categoryNames,
    @required this.categoryImages,
  });

  factory Category.fromFirestore(Map<dynamic, dynamic> data) {
    return data != null
        ? Category(
            categoryName: data["categoryName"],
            categoryImage: data["categoryImage"],
            restroName: data["restroName"],
            categoryNames: data["categoryNames"],
            categoryImages: data["categoryImages"],
          )
        : null;
  }
}
