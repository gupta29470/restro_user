import 'package:flutter/material.dart';

class DisplayRestaurantNameWidget extends StatelessWidget {
  final String restaurantName;

  const DisplayRestaurantNameWidget({
    @required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                restaurantName,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
