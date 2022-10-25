import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MoviesList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoviesList(),
    );
  }
}
