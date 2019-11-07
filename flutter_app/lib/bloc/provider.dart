import 'package:flutter_app/model/fooditem.dart';

class CartProvider {
  List<FoodItem> foodItems = [];
  List<FoodItem> addTolist(FoodItem foodItem) {
    foodItems.add(foodItem);
    return foodItems;
  }

  List<FoodItem> removeTolist(FoodItem foodItem) {
    foodItems.remove(foodItem);
    return foodItems;
  }
}
