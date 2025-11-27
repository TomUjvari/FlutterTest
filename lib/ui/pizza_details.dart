import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/option_item.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza pizza;
  final Cart cart;

  const PizzaDetails({required this.pizza, required this.cart, super.key});

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  late int _selectedPate;
  late int _selectedTaille;
  late int _selectedSauce;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedPate = widget.pizza.pate;
    _selectedTaille = widget.pizza.taille;
    _selectedSauce = widget.pizza.sauce;
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    double totalPrice = widget.pizza.price;

    final selectedPate = Pizza.pates.firstWhere((p) => p.value == _selectedPate);
    totalPrice += selectedPate.supplement;

    final selectedTaille = Pizza.tailles.firstWhere((t) => t.value == _selectedTaille);
    totalPrice += selectedTaille.supplement;

    final selectedSauce = Pizza.sauces.firstWhere((s) => s.value == _selectedSauce);
    totalPrice += selectedSauce.supplement;

    setState(() {
      _totalPrice = totalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.pizza.title,
        cart: widget.cart,
      ),
      body: SingleChildScrollView( // To avoid overflow if content is too long
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.pizza.image,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.pizza.title,
              style: PizzeriaStyle.headerTextStyle, // Apply style
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Recette:',
              style: PizzeriaStyle.subHeaderTextStyle, // Apply style
            ),
            const SizedBox(height: 8),
            Text(
              widget.pizza.garniture,
              style: PizzeriaStyle.regularTextStyle, // Apply style
            ),
            const SizedBox(height: 24),

            // Pate and Taille Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Pâte', border: OutlineInputBorder()),
                    value: _selectedPate,
                    items: Pizza.pates.map((pate) {
                      return DropdownMenuItem<int>(
                        value: pate.value,
                        child: Text(pate.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPate = newValue!;
                        _calculateTotalPrice();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Taille', border: OutlineInputBorder()),
                    value: _selectedTaille,
                    items: Pizza.tailles.map((taille) {
                      return DropdownMenuItem<int>(
                        value: taille.value,
                        child: Text(taille.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedTaille = newValue!;
                        _calculateTotalPrice();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Sauce Dropdown
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Sauce', border: OutlineInputBorder()),
              value: _selectedSauce,
              items: Pizza.sauces.map((sauce) {
                return DropdownMenuItem<int>(
                  value: sauce.value,
                  child: Text(sauce.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedSauce = newValue!;
                  _calculateTotalPrice();
                });
              },
            ),
            const SizedBox(height: 24),

            // Total Price
            TotalWidget(_totalPrice),
            const SizedBox(height: 16),

            // Add to Cart Button
            ElevatedButton(
              onPressed: () {
                final pizza = Pizza(
                  widget.pizza.id,
                  widget.pizza.title,
                  widget.pizza.garniture,
                  widget.pizza.image,
                  _totalPrice,
                  pate: _selectedPate,
                  taille: _selectedTaille,
                  sauce: _selectedSauce,
                );
                widget.cart.addPizza(pizza);

                final snackBar = SnackBar(
                  content: Text('${pizza.title} ajouté au panier'),
                  duration: const Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Ajouter au panier'),
            ),
          ],
        ),
      ),
    );
  }
}
