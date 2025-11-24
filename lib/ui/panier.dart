import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';

class Panier extends StatefulWidget {
  final Cart cart;
  const Panier({required this.cart, super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  void _removeItem(CartItem item) {
    setState(() {
      widget.cart.removePizza(item.pizza);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.totalItems(),
              itemBuilder: (context, index) {
                final item = widget.cart.getCartItem(index);
                return ListTile(
                  leading: Image.asset('assets/img/pizzas/${item.pizza.image}'),
                  title: Text(item.pizza.title),
                  subtitle: Text('Quantité: ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${(item.pizza.price * item.quantity).toStringAsFixed(2)} €'),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeItem(item),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total HT'),
                    Text('${widget.cart.totalHT.toStringAsFixed(2)} €'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TVA (10%)'),
                    Text('${widget.cart.tva.toStringAsFixed(2)} €'),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total TTC', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${widget.cart.totalTTC.toStringAsFixed(2)} €', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
