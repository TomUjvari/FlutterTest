import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'models/menu.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart'; // Import the styles

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleLarge: PizzeriaStyle.pageTitleTextStyle,
          bodyMedium: PizzeriaStyle.regularTextStyle,
          displayMedium: PizzeriaStyle.headerTextStyle,
        ),
      ),
      home: const MyHomePage(title: 'Ma Pizzeria'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Cart _cart = Cart();

  final _menus = const [
    Menu(1, 'Entrées', 'entree.jpg', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizza.jpg', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.jpg', Colors.brown),
    Menu(4, 'Boissons', 'boisson.jpg', Colors.lightBlue)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, cart: _cart),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _menus.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              switch (_menus[index].type) {
                case 2: // Pizza
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PizzaList(cart: _cart)),
                  );
                  break;
              }
            },
            child: _buildRow(_menus[index]),
          );
        },
      ),
    );
  }

  Widget _buildRow(Menu menu) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/img/menus/${menu.image}',
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              menu.title,
              style: PizzeriaStyle.headerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
