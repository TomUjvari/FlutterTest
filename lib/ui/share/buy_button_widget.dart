import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';

class BuyButtonWidget extends StatelessWidget {
  final Cart cart;
  final Pizza pizza;

  const BuyButtonWidget({required this.cart, required this.pizza, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        cart.addPizza(pizza);
        final snackBar = SnackBar(
          content: Text('${pizza.title} ajouté au panier'),
          duration: const Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      icon: const Icon(Icons.shopping_cart),
      style: IconButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
