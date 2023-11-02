import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, Object>> cart = [];

  addProduct(Map<String, Object> product) {
    cart.add(product);
    notifyListeners();
  }

  removeProduct(int index) {
    cart.removeAt(index);
    notifyListeners();
  }
}
