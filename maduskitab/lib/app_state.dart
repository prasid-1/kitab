import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Model class for an item in the basket
class BasketItem {
  String name;
  double rating;
  String description;
  int price;
  int quantity;

  BasketItem({
    required this.name,
    required this.rating,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  // List to store the basket items
  var basketItems = <BasketItem>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  // Add item to the basket or increase its quantity if it already exists
  void addItemToBasket(BasketItem item) {
    var existingItem = basketItems.firstWhere(
      (basketItem) => basketItem.name == item.name,
      orElse: () => BasketItem(
        name: '',
        rating: 0,
        description: '',
        price: 0,
      ),
    );

    if (existingItem.name != '') {
      existingItem.quantity += 1;
    } else {
      basketItems.add(item);
    }

    notifyListeners();
  }

  // Decrease item quantity or remove if quantity is 1
  void removeItemFromBasket(BasketItem item) {
    var existingItem = basketItems.firstWhere(
      (basketItem) => basketItem.name == item.name,
      orElse: () => BasketItem(
        name: '',
        rating: 0,
        description: '',
        price: 0,
      ),
    );

    if (existingItem.name != '') {
      if (existingItem.quantity > 1) {
        existingItem.quantity -= 1;
      } else {
        basketItems.remove(existingItem);
      }
      notifyListeners();
    }
  }
}
