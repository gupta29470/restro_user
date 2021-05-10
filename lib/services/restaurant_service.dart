import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home_screen.dart';
import '../models/restaurant.dart';

class RestaurantService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static RestaurantService restaurantServiceInstance = RestaurantService();

  Stream<List<Restaurant>> getAllRestaurants(
    double userLat,
    double userLong,
    double lowerLat,
    double lowerLon,
    double greaterLat,
    double greaterLon,
  ) {
    final reference = _firestore
        .collection("restaurants");
    return reference.get().asStream().map((snapshot) {
      return snapshot.docs.map((document) {
        return Restaurant.fromJSON(
          document.data(),
        );
      }).toList();
    });
  }
}
