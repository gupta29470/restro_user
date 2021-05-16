import 'package:flutter/foundation.dart';

class Menu {
  final String category;
  final List<dynamic> itemNames;
  final List<dynamic> itemImages;
  final List<dynamic> itemPrices;

  Menu(
      {@required this.category,
      @required this.itemNames,
      @required this.itemImages,
      @required this.itemPrices,
      });

  factory Menu.fromFirestore(Map<dynamic, dynamic> data) {
    return data != null
        ? Menu(
            category: data["categoryName"],
            itemNames: data["itemNames"],
            itemImages: data["itemImages"],
            itemPrices: data["itemPrices"],
          )
        : null;
  }
}
