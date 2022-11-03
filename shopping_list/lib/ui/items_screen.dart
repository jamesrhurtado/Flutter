import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_items.dart';
import 'package:shopping_list/models/shopping_list.dart';
import 'package:shopping_list/util/dbhelper.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  ItemsScreen(this.shoppingList);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  _ItemsScreenState(this.shoppingList);

  DbHelper? helper;
  List<ListItems> items = [];

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(shoppingList.id);

    return Scaffold(
      appBar: AppBar(title: Text(shoppingList.name)),
      body: ListView.builder(
          // ignore: unnecessary_null_comparison
          itemCount: (items != null) ? items.length : 0,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              title: Text(items[index].name),
              subtitle: Text(
                  'Quantity: ${items[index].quantity} - Note: ${items[index].note}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            );
          }),
    );
  }

  Future showData(int idList) async {
    await helper!.openDb();

    items = await helper!.getItems(idList);

    setState(() {
      items = items;
    });
  }
}
