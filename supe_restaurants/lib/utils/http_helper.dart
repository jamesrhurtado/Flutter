import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../database/database.dart';

class HttpHelper {
  final String urlBase =
      'https://probable-knowledgeable-zoo.glitch.me/restaurants';
  Future<List<Restaurant>> getRestaurants() async {
    http.Response result = await http.get(Uri.parse(urlBase));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final restaurantsMap = jsonResponse;

      List<Restaurant> restaurants =
          restaurantsMap.map<Restaurant>((i) => Restaurant.fromJson(i)).toList();

      return restaurants;
    } else {
      print(result.body);
      return null!;
    }
  }
}
