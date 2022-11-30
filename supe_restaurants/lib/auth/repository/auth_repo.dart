import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:supe_restaurants/auth/secure_storage.dart';

class AuthRepository {
  final storage = SecureStorage();
  final String userId = 'userId';
  login(String username, String password) async {
    const urlBase = 'https://probable-knowledgeable-zoo.glitch.me/users?';
    final String finalUrl = '${urlBase}username=$username&password=$password';
    var response = await http.post(Uri.parse(finalUrl),
        headers: {'Content-Type': 'application/json; charset=utf-8'});
    final data = json.decode(response.body);

    if (data['id'] != null) {
      storage.setUserId(data['id'].toString());
      return data;
    } else {
      return "There was a problem while authenticating";
    }
  }
}
