import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/restaurant.dart';
import '../services/restaurant_service.dart';

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
  String _currentAddress;

  double userLat;
  double userLon;

  double lat = 0.0144927536231884;
  double lon = 0.0181818181818182;
  double distance = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restro"),
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

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildRestaurant() {
    _getCurrentLocation();
    return StreamBuilder<List<Restaurant>>(
      stream: RestaurantService.restaurantServiceInstance.getAllRestaurants(
        userLat,
        userLon,
        HomeScreen.lowerLat,
        HomeScreen.lowerLon,
        HomeScreen.greaterLat,
        HomeScreen.greaterLon,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
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
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data[index] != null) {
                        _getAddressFromLatLng(
                            data[index].latitude, data[index].longitude);
                      }
                      return data[index] != null
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Hero(
                                      tag: data[index].logoURL,
                                      child: Image(
                                        height: 150,
                                        width: 150,
                                        image:
                                            NetworkImage(data[index].logoURL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data[index].restaurantName,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (_currentAddress != null)
                                            Text(
                                              _currentAddress,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            '0.2 miles away',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              color: Colors.indigoAccent,
                            );
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitPouringHourglass(
                    color: Colors.deepOrangeAccent,
                    size: 100.0,
                  ),
                  Text(
                    "Fetching Restaurants",
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Please wait...",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
