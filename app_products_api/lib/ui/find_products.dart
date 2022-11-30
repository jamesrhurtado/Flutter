import 'package:app_products_api/main.dart';
import 'package:app_products_api/utils/http_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app_products_api/database/database.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';

class FindProducts extends StatefulWidget {
  const FindProducts({super.key});

  @override
  State<FindProducts> createState() => _FindProductsState();
}

class _FindProductsState extends State<FindProducts> {
  List<Product> products = [];
  int? productsCount;
  bool loading = true;
  HttpHelper? helper;
  late MyDatabase appDatabase;
  late TextEditingController productName;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    productName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Product"),
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
          TextFormField(
            controller: productName,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "What's the product you are looking for?"),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                products.clear();
                helper!.getProduct(productName.text.toString()).then((value) {
                  products += value;
                  setState(() {
                    productsCount = products.length;
                    products = products;
                  });
                });
              },
              child: const Text("Find")),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductRow(products[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProductRow extends StatefulWidget {
  final Product product;

  const ProductRow(this.product, {super.key});

  @override
  State<ProductRow> createState() => _ProductRowState(product);
}

class _ProductRowState extends State<ProductRow> {
  Product product;
  _ProductRowState(this.product);

  late bool favourite;
  late MyDatabase appDatabase;
  @override
  void initState() {
    favourite = false;
    //isFavourite(product);
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
          tag: 'poster_${product.id}',
          child: Image.network(product.image.toString()),
        ),
        title: Text(widget.product.title.toString()),
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
            appDatabase.insertProduct(ProductsCompanion(
                id: dr.Value(product.id),
                title: dr.Value(product.title),
                image: dr.Value(product.image),
                imageType: dr.Value(product.imageType)));
            showToast(context);
          },
        ),
      ),
    );
  }

  bool isFavourite(Product product) {
    var favouriteProduct = [];
    appDatabase
        .getByProductId(product.id)
        .then((value) => favouriteProduct = value);
    print(favouriteProduct.isNotEmpty);
    return favouriteProduct.isNotEmpty;
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favourites'),
        action: SnackBarAction(label: 'DISMISS', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
