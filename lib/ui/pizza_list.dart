import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/pizza_data.dart';
import 'package:pizzeria/services/pizzeria_service.dart';
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
  late Future<List<Pizza>> _pizzas;
  PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    super.initState();
    _pizzas =_service.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Pizzas",
        cart: widget.cart,
      ),
      body: FutureBuilder<List<Pizza>>(
        future: _pizzas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Impossible de récupérer les données : ${snapshot.error}',
                style: PizzeriaStyle.errorTextStyle,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _buildListView(List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        return _buildRow(pizzas[index]);
      },
    );
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
            Image.network(
              pizza.image,
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
