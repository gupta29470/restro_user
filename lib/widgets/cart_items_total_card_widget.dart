import 'package:flutter/material.dart';

class CartItemCardTotalWidget extends StatelessWidget {
  final String total;

  const CartItemCardTotalWidget({
    @required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Total',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Spacer(),
            Chip(
              label: Text(
                '₹ $total',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
