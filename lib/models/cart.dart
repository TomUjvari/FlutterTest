import 'package:pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart {
  final List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addPizza(Pizza pizza) {
    // Check if the pizza is already in the cart
    for (var item in _items) {
      if (item.pizza.id == pizza.id) {
        item.quantity++;
        return;
      }
    }
    // If not, add a new item
    _items.add(CartItem(pizza));
  }

  void removePizza(Pizza pizza) {
    _items.removeWhere((item) => item.pizza.id == pizza.id);
  }

  double get totalHT {
    double total = 0.0;
    for (var item in _items) {
      total += item.pizza.price * item.quantity;
    }
    return total;
  }

  double get tva {
    return totalHT * 0.1;
  }

  double get totalTTC {
    return totalHT + tva;
  }
}
