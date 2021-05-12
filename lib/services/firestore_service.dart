import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/restaurant.dart';
import '../models/category.dart';
import '../models/menu.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirestoreService firestoreServiceInstance = FirestoreService();

  Stream<List<Restaurant>> getAllRestaurants(
    double userLat,
    double userLong,
    double lowerLat,
    double lowerLon,
    double greaterLat,
    double greaterLon,
  ) {
    final reference = _firestore.collection("restaurants");
    return reference.get().asStream().map(
      (snapshot) {
        return snapshot.docs.map(
          (document) {
            return Restaurant.fromFirestore(
              document.data(),
            );
          },
        ).toList();
      },
    );
  }

  Stream<List<Category>> getCategoriesByRestaurant(String restaurantName) {
    final reference = _firestore.collection("categories").where(
          "restroName",
          isEqualTo: restaurantName,
        );
    if (reference == null) {
      print("null");
    } else {
      print("no null");
    }
    return reference.get().asStream().map(
      (snapshot) {
        return snapshot.docs.map(
          (document) {
            return Category.fromFirestore(
              document.data(),
            );
          },
        ).toList();
      },
    );
  }

  Stream<List<Menu>> getMenusByCategory(String categoryName) {
    final reference = _firestore.collection("menus").where(
          "categoryName",
          isEqualTo: categoryName,
        );
    if (reference == null) {
      print("null");
    } else {
      print("no null");
    }
    return reference.get().asStream().map(
      (snapshot) {
        return snapshot.docs.map(
          (document) {
            return Menu.fromFirestore(
              document.data(),
            );
          },
        ).toList();
      },
    );
  }
}
