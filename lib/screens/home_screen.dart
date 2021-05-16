import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/restaurant.dart';
import '../widgets/loading_text_widget.dart';
import '../services/firestore_service.dart';
import 'restaurant_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_loading_indicator.dart';
import '../widgets/restaurants_containers_widget.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static double lowerLat;
  static double lowerLon;
  static double greaterLat;
  static double greaterLon;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position _currentPosition;

  double userLat;
  double userLon;

  double lat = 0.0144927536231884;
  double lon = 0.0181818181818182;
  double distance = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restro"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () =>
                AuthProvider.authServiceInstance.signOutAnonymously(),
            child: Text(
              "LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _buildRestaurant(),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLat = _currentPosition.latitude;
        userLon = _currentPosition.longitude;
        HomeScreen.lowerLat = userLat - (lat * distance);
        HomeScreen.lowerLon = userLon - (lon * distance);
        HomeScreen.greaterLat = userLat + (lat * distance);
        HomeScreen.greaterLon = userLon + (lon * distance);

        print(userLat);
        print(userLon);
        print(HomeScreen.lowerLat);
        print(HomeScreen.lowerLon);
        print(HomeScreen.greaterLat);
        print(HomeScreen.greaterLon);
      });
    }).catchError(
      (e) {
        print(e);
      },
    );
  }

  Widget _buildRestaurant() {
    _getCurrentLocation();
    return StreamBuilder<List<Restaurant>>(
      stream: FirestoreService.firestoreServiceInstance.getAllRestaurants(
        userLat,
        userLon,
        HomeScreen.lowerLat,
        HomeScreen.lowerLon,
        HomeScreen.greaterLat,
        HomeScreen.greaterLon,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> data = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Nearby Restaurants",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Restaurant restaurant = data[index];
                    return data[index] != null
                        ? GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RestaurantScreen(
                                  restaurant: restaurant,
                                ),
                              ),
                            ),
                            child: RestaurantsContainerWidget(
                              logoURL: data[index].logoURL,
                              restaurantName: data[index].restaurantName,
                            ),
                          )
                        : Container(
                            color: Colors.indigoAccent,
                          );
                  },
                ),
              )
            ],
          );
        } else {
          return LoadingWidget(
            text1: "Fetching Restaurants",
            text2: "Please Wait...",
          );
        }
      },
    );
  }
}
