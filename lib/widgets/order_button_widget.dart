import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/order_successful_screen.dart';
import '../providers/cart_provider.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return TextButton(
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
          'ORDER NOW',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          cart.cartItems.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderSuccessfulScreen(),
            ),
          );
        }
    );
  }
}
