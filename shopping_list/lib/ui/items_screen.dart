import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_items.dart';
import 'package:shopping_list/models/shopping_list.dart';
import 'package:shopping_list/ui/list_item_dialog.dart';
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
    ListItemDialog dialog = ListItemDialog();
    helper = DbHelper();
    showData(shoppingList.id);

    return Scaffold(
      appBar: AppBar(title: Text(shoppingList.name)),
      body: ListView.builder(
          itemCount: (items != null) ? items.length : 0,
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
              key: Key(items[index].name),
              onDismissed: (direction){
                String strName = items[index].name;
                helper!.deleteItem(items[index]);
                setState(() {
                  items.removeAt(index);
                });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$strName has been removed")));
              },
          child: ListTile(
                title: Text(items[index].name),
                subtitle: Text(
                    'Quantity: ${items[index].quantity} - Note: ${items[index].note}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            dialog.buildDialog(context, items[index], false));
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => dialog.buildDialog(
                  context, ListItems(0, shoppingList.id, '', '', ''), true));
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.add),
      ),  
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
