import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../screens/home_screen.dart';

class Restaurant {
  final String id;
  final String restaurantName;
  final String logoURL;
  final double latitude;
  final double longitude;
  final GeoPoint position;

  Restaurant({
    @required this.id,
    @required this.restaurantName,
    @required this.logoURL,
    @required this.latitude,
    @required this.longitude,
    this.position,
  });

  factory Restaurant.fromJSON(Map<dynamic, dynamic> data) {

    if (data != null) {
      if (data["latitude"] < HomeScreen.lowerLat) {
        data["latitude"] = 0;
      }
      if (data["longitude"] < HomeScreen.lowerLon) {
        data["latitude"] = 0;
      }
      if (data["latitude"] > HomeScreen.greaterLat) {
        data["latitude"] = 0;
      }
      if (data["longitude"] > HomeScreen.greaterLon) {
        data["longitude"] = 0;
      }

      if (data["latitude"] != 0 && data["longitude"] != 0) {
        return Restaurant(
          id: data["id"],
          restaurantName: data["restaurantName"],
          latitude: data["latitude"],
          longitude: data["longitude"],
          logoURL: data["logoURL"],
          position: data["position"],
        );
      }
    }
    return null;
  }
}
