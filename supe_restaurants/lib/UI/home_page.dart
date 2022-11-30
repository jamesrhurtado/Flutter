import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/UI/favourite_restaurants.dart';
import 'package:supe_restaurants/UI/find_restaurants.dart';
import 'package:supe_restaurants/UI/login_user.dart';
import 'package:supe_restaurants/auth/secure_storage.dart';
import 'package:supe_restaurants/database/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyDatabase appDatabase;
  final storage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => MyDatabase(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Container(
            alignment: FractionalOffset.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('See Restaurants',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FindRestaurants()),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Favourite Restaurants',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavouriteRestaurants()),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Log out',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()),
                    );
                    await storage.deleteAll();
                  },
                ),
              ],
              
            ),
          ),
          
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}