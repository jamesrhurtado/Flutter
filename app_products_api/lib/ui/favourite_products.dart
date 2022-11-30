import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app_products_api/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as dr;

class FavouriteProducts extends StatefulWidget {
  const FavouriteProducts({super.key});

  @override
  State<FavouriteProducts> createState() => _FavouriteProductsState();
}

class _FavouriteProductsState extends State<FavouriteProducts> {
  late MyDatabase appDatabase;
  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<MyDatabase>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favourite Products"),
        ),
        body: FutureBuilder<List<Product>>(
          future: appDatabase.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product>? productList = snapshot.data;
              return ListView.builder(
                  itemCount: productList!.length,
                  itemBuilder: (context, index) {
                    Product product = productList[index];
                    return ListTile(
                      leading: Hero(
                        tag: 'poster_${product.id}',
                        child: Image.network(product.image.toString()),
                      ),
                      title: Text(product.title.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.restore_from_trash),
                        color: Colors.grey,
                        onPressed: () {
                          appDatabase.deleteProduct(ProductsCompanion(
                              id: dr.Value(product.id),
                              title: dr.Value(product.title),
                              image: dr.Value(product.image),
                              imageType: dr.Value(product.imageType)));
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
        content: const Text('Product removed. Update the page to see the changes'),
        action: SnackBarAction(label: 'DISMISS', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
