import 'package:pizzeria/models/option_item.dart';

class Pizza {
  final int id;
  final String title;
  final String garniture;
  final String image;
  final double price;

  // Séléction de l'utilisateur
  int pate;
  int taille;
  int sauce;

  // Les options possibles
  static final List<OptionItem> pates = [
    OptionItem(0, "Pâte fine"),
    OptionItem(1, "Pâte épaisse", supplement: 2),
  ];
  static final List<OptionItem> tailles = [
    OptionItem(0, "Moyenne"),
    OptionItem(1, "Grande", supplement: 2),
  ];
  static final List<OptionItem> sauces = [
    OptionItem(0, "Base tomate"),
    OptionItem(1, "Base crême", supplement: 2),
  ];

  Pizza.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        garniture = json['garniture'],
        image = json['image'],
        price = json['price'],
        pate = 0,
        taille = 0,
        sauce = 0;

  Pizza(this.id, this.title, this.garniture, this.image, this.price, {this.pate = 0, this.taille = 0, this.sauce = 0});
}
