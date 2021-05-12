import 'package:flutter/material.dart';

import '../services/firestore_service.dart';
import '../models/menu.dart';
import '../widgets/menus_container_widget.dart';
import '../widgets/custom_loading_indicator.dart';
import '../widgets/loading_text_widget.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantName;
  final String categoryName;

  const MenuScreen({
    @required this.restaurantName,
    @required this.categoryName,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.restaurantName} Menus'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildMenuWidget(),
        ],
      ),
    );
  }

  Widget _buildMenuWidget() {
    return StreamBuilder<List<Menu>>(
      stream: FirestoreService.firestoreServiceInstance
          .getMenusByCategory(widget.categoryName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Menu> data = snapshot.data;
          for (int index = 0; index < data.length; index++) {
            List<dynamic> itemNames = data[index].itemNames;
            List<dynamic> itemImages = data[index].itemImages;
            List<dynamic> itemPrices = data[index].itemPrices;
            if (itemImages != null && itemNames != null) {
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    itemImages.length,
                    (index) {
                      return MenusContainerWidget(
                        itemName: itemNames[index],
                        itemImage: itemImages[index],
                        itemPrice: itemPrices[index],
                      );
                    },
                  ),
                ),
              );
            } else {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.room_service,
                      color: Colors.black54,
                      size: 80.0,
                    ),
                    LoadingTextWidget(
                      text1: "Menus Coming Soon",
                      text2: "Please Check Later...",
                    ),
                  ],
                ),
              );
            }
          }
        }
        return Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomLoadingIndicator.customLoadingIndicator(100),
                LoadingTextWidget(
                  text1: "Fetching Menus",
                  text2: "Please Wait...",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
