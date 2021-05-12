import 'package:flutter/material.dart';

class DisplayRestaurantImageWidget extends StatelessWidget {
  final String logoURL;

  const DisplayRestaurantImageWidget({
    @required this.logoURL,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: logoURL,
          child: Image(
            height: 250.0,
            width: MediaQuery.of(context).size.width,
            image: NetworkImage(logoURL),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
