import 'package:flutter/foundation.dart';
import '../models/cart.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _cartItems = {};
  static CartProvider cartProviderInstance = CartProvider();

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get countItem {
    int totalItems = 0;
    _cartItems.forEach((key, cartItem) {
      totalItems += cartItem.quantity;
    });
    return totalItems;
  }

  double get totalAmount {
    var totalAmount = 0.0;
    _cartItems.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.quantity;
    });
    return totalAmount;
  }

  void addItem(
    dynamic itemName,
    dynamic itemImage,
    dynamic price,
    dynamic date,
    dynamic time,
  ) {
    if (_cartItems.containsKey(itemName)) {
      _cartItems.update(
        itemName,
        (existingItem) {
          return CartItem(
            itemName: existingItem.itemName,
            itemImage: existingItem.itemImage,
            price: existingItem.price,
            quantity: existingItem.quantity + 1,
            date: existingItem.date,
            time: existingItem.time,
          );
        },
      );
    } else {
      _cartItems.putIfAbsent(
        itemName,
        () {
          return CartItem(
            itemName: itemName,
            itemImage: itemImage,
            price: price,
            quantity: 1,
            date: date,
            time: time,
          );
        },
      );
    }
    notifyListeners();
  }
  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
