import 'package:app_credentials_drift/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_credentials_drift/ui/listUser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => MyDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: listUser(),
      ),
    );
  }
}
