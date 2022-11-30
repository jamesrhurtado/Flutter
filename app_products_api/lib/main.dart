import 'package:app_products_api/ui/favourite_products.dart';
import 'package:app_products_api/ui/find_products.dart';
import 'package:flutter/material.dart';
import 'package:app_products_api/database/database.dart';
import 'package:provider/provider.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'My Products',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Welcome to Product Finder'),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          alignment: FractionalOffset.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Find Products',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FindProducts()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Saved Products',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavouriteProducts()),
                  );
                },
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
