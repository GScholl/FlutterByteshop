import 'package:flutter/material.dart';
import '../models/product.dart';  // Supondo que você tenha uma classe Product.
import 'package:flutter/foundation.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addItem(Product product) {
    _cart.addItem(product);
    print("fez algo");
    notifyListeners();
  }

  void removeItem(Product product) {
    _cart.removeItem(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.clearCart();
    notifyListeners();
  }
}