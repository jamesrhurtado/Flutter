import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../database/database.dart';

class HttpHelper {
  //https://api.spoonacular.com/food/products/search?query=arroz&number=10&apiKey=e5fb9e631aa648cd8755e6db27d0d086
  //https://api.themoviedb.org/3/movie/upcoming?api_key=3cae426b920b29ed2fb1c0749f258325
  final String urlBase =
      'https://api.spoonacular.com/food/products/search?query=';
  final String urlKey = 'apiKey=e5fb9e631aa648cd8755e6db27d0d086';
  final String urlNumber = '&number=10&';

  Future<List<Product>> getProduct(String product) async {
    final String upcoming = urlBase + product.toLowerCase() + urlNumber + urlKey;
    print(upcoming);
    print(product);
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final productsMap = jsonResponse['products'];

      List<Product> products =
          productsMap.map<Product>((i) => Product.fromJson(i)).toList();

      return products;
    } else {
      print(result.body);
      return null!;
    }
  }
}
