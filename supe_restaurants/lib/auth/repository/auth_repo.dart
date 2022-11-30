import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  login(String username, String password) async {
    const urlBase = 'https://probable-knowledgeable-zoo.glitch.me/users?';
    final String finalUrl = '${urlBase}username=$username&password=$password';
    var response = await http.post(Uri.parse(finalUrl),
        headers: {'Content-Type': 'application/json; charset=utf-8'});
    final data = json.decode(response.body);

    if (data['id'] != null) {
      return data;
    } else {
      return "There was a problem while authenticating";
    }
  }
}
