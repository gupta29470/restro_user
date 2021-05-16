import 'package:flutter/material.dart';


import '../models/restaurant.dart';
import '../models/category.dart';
import '../services/firestore_service.dart';
import '../widgets/display_restaurant_image_widget.dart';
import '../widgets/display_restaurant_name_widget.dart';
import '../widgets/loading_text_widget.dart';
import '../widgets/categories_container_widget.dart';
import '../widgets/loading_widget.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantScreen({@required this.restaurant});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  double height, width, itemHeight, itemWidth;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          DisplayRestaurantImageWidget(logoURL: widget.restaurant.logoURL),
          DisplayRestaurantNameWidget(
              restaurantName: widget.restaurant.restaurantName),
          _displayCategoryTextWidget(),
          _buildCategoriesWidget(widget.restaurant.restaurantName),
        ],
      ),
    );
  }

  Widget _displayCategoryTextWidget() {
    return Center(
      child: Text(
        'Categories',
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCategoriesWidget(String restaurantName) {
    return StreamBuilder<List<Category>>(
      stream: FirestoreService.firestoreServiceInstance
          .getCategoriesByRestaurant(restaurantName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Category> data = snapshot.data;
          for (int index = 0; index < data.length; index++) {
            List<dynamic> categoryNames = data[index].categoryNames;
            List<dynamic> categoryImages = data[index].categoryImages;
            String restaurantName = data[index].restroName;
            if (categoryImages != null && categoryNames != null) {
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    categoryNames.length,
                    (index) {
                      return CategoriesContainerWidget(
                        categoryName: categoryNames[index],
                        categoryImage: categoryImages[index],
                        restaurantName: restaurantName,
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
                      text1: "Categories Coming Soon",
                      text2: "Please Check Later...",
                    ),
                  ],
                ),
              );
            }
          }
        }
        return LoadingWidget();
      },
    );
  }
}
