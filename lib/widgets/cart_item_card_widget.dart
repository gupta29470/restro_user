import 'package:flutter/material.dart';

class CardItemCardWidget extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final int price;
  final int quantity;
  final String date;
  final String time;

  const CardItemCardWidget({
    @required this.itemName,
    @required this.itemImage,
    @required this.price,
    @required this.quantity,
    @required this.date,
    @required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(
                      itemImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                  "$itemName"),
              subtitle: Text(
                'Total : ₹${(price * quantity)}',
              ),
              trailing: Text(
                '$quantity unit',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${date.toString()}',
                ),
                Text(
                  '${time.toString()}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
