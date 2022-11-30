import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:supe_restaurants/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as dr;

class FavouriteRestaurants extends StatefulWidget {
  const FavouriteRestaurants({super.key});

  @override
  State<FavouriteRestaurants> createState() => _FavouriteRestaurantsState();
}

class _FavouriteRestaurantsState extends State<FavouriteRestaurants> {
  late MyDatabase appDatabase;
  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<MyDatabase>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favourite Restaurants"),
        ),
        body: FutureBuilder<List<Restaurant>>(
          future: appDatabase.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Restaurant>? restaurantList = snapshot.data;
              return ListView.builder(
                  itemCount: restaurantList!.length,
                  itemBuilder: (context, index) {
                    Restaurant restaurant = restaurantList[index];
                    return ListTile(
                      leading: Hero(
                        tag: 'poster_${restaurant.id}',
                        child: Image.network(restaurant.poster.toString()),
                      ),
                      title: Text(restaurant.title.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.restore_from_trash),
                        color: Colors.grey,
                        onPressed: () {
                          appDatabase.deleteProduct(RestaurantsCompanion(
                            id: dr.Value(restaurant.id),
                            title: dr.Value(restaurant.title),
                            poster: dr.Value(restaurant.poster),
                          ));
                          showToast(context);
                        },
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text(""),
              );
            }
          },
        ));
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:
            const Text('Product removed. Update the page to see the changes'),
        action: SnackBarAction(
            label: 'DISMISS', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  
}
