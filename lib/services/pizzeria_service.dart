import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pizza.dart';

class PizzeriaService {

  static final String uri = 'http://10.0.2.2/api/';
  static final String imageBaseUrl = 'http://10.0.2.2/static/images/';

  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];

    try {
      final response = await http.get(Uri.parse('${uri}/pizzas'));

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for (final value in json) {
          // Construct the full image URL before creating the Pizza object
          // Create a mutable map to modify the 'image' field
          Map<String, dynamic> pizzaJson = Map<String, dynamic>.from(value);
          pizzaJson['image'] = '$imageBaseUrl${pizzaJson['image']}';
          list.add(Pizza.fromJson(pizzaJson));
        }
      } else {
        throw Exception('Impossible de récupérer les pizzas');
      }
    } catch (e) {
      throw e;
    }
    return list;
  }
}