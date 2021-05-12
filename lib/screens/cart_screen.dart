import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/order_button_widget.dart';
import '../widgets/cart_item_card_widget.dart';
import '../widgets/cart_items_total_card_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        actions: [
          OrderButton(),
        ],
      ),
      body: Column(
        children: [
          CartItemCardTotalWidget(
            total: cart.totalAmount.toString(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                return CardItemCardWidget(
                  itemName: cart.cartItems.values.toList()[index].itemName,
                  itemImage: cart.cartItems.values.toList()[index].itemImage,
                  price: cart.cartItems.values.toList()[index].price,
                  quantity: cart.cartItems.values.toList()[index].quantity,
                  date: cart.cartItems.values.toList()[index].date,
                  time: cart.cartItems.values.toList()[index].time,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
