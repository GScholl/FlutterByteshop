import 'cart_item.dart';
import 'product.dart';

class Cart {
  List<CartItem> items = [];

  void addItem(Product product) {
    // Verifica se o produto já está no carrinho
    CartItem? existingItem = items.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: Product(id: 0, name: "", price: 0.00, description: "", imagePath: "")));

    if (existingItem.product.id != 0) {
      existingItem.quantity++;
    } else {
      items.add(CartItem(product: product));
    }
  }

  void removeItem(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  void clearCart() {
    items.clear();
  }

  double get totalAmount {
    return items.fold(
        0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}