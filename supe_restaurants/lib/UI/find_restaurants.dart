import 'package:supe_restaurants/main.dart';
import 'package:supe_restaurants/utils/http_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/utils/http_helper.dart';
import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:supe_restaurants/database/database.dart';

class FindRestaurants extends StatefulWidget {
  const FindRestaurants({super.key});
  @override
  State<FindRestaurants> createState() => _FindRestaurantsState();
}

class _FindRestaurantsState extends State<FindRestaurants> {
  List<Restaurant> restaurants = [];
  int? restaurantsCount;
  bool loading = true;
  HttpHelper? helper;
  late MyDatabase appDatabase;

  Future initialize() async {
    //ojo
    //movies = List<Movie>();
    loadData();
  }

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Restaurants"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left_outlined,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                return RestaurantRow(restaurants[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  void loadData() {
    helper!.getRestaurants().then((value) {
      restaurants += value;
      setState(() {
        restaurantsCount = restaurants.length;
        restaurants = restaurants;
      });

      if (restaurants.length % 20 > 0) {
        loading = false;
      }
    });
  }
}

class RestaurantRow extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantRow(this.restaurant, {super.key});

  @override
  State<RestaurantRow> createState() => _RestaurantRowState(restaurant);
}

class _RestaurantRowState extends State<RestaurantRow> {
  Restaurant restaurant;
  _RestaurantRowState(this.restaurant);

  late bool favourite;
  late MyDatabase appDatabase;
  @override
  void initState() {
    favourite = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<MyDatabase>(context);
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: Hero(
          tag: 'poster_${restaurant.id}',
          child: Image.network(restaurant.poster.toString()),
        ),
        title: Text(widget.restaurant.title.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const MyApp()),
          ).then((value) {
            //isFavourite(movie);
          });
        },
        trailing: IconButton(
          icon: const Icon(Icons.add),
          color: Colors.grey,
          onPressed: () {
            appDatabase.insertProduct(RestaurantsCompanion(
                id: dr.Value(restaurant.id),
                title: dr.Value(restaurant.title),
                poster: dr.Value(restaurant.poster)));
            showToast(context);
          },
        ),
      ),
    );
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favourites'),
        action: SnackBarAction(
            label: 'DISMISS', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
