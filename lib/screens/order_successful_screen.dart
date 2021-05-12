import 'package:flutter/material.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "home",
                );
              }),
        ],
      ),
      body: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 450,
              width: 550,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/order_success.png"),
                ),
              ),
            ),
            Text(
              "Order Successful",
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
