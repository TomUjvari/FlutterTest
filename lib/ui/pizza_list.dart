import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/pizza_data.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart'; // Import the styles

class PizzaList extends StatefulWidget {
  final Cart cart;
  const PizzaList({required this.cart, super.key});

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  List<Pizza> _pizzas = [];

  @override
  void initState() {
    super.initState();
    _pizzas = PizzaData.buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: 'Nos Pizzas', cart: widget.cart),
        body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _pizzas.length,
            itemBuilder: (context, index) {
              return _buildRow(_pizzas[index]);
            }));
  }

  Widget _buildRow(Pizza pizza) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell( // Make the card tappable
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PizzaDetails(pizza: pizza, cart: widget.cart), // Navigate to details
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(pizza.title,
                  style: PizzeriaStyle.headerTextStyle), // Apply style
            ),
            Image.asset(
              'assets/img/pizzas/${pizza.image}',
              height: 120,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(pizza.garniture, style: PizzeriaStyle.regularTextStyle), // Apply style
                  ),
                  BuyButtonWidget(pizza: pizza, cart: widget.cart,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
