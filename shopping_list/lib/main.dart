import 'package:flutter/material.dart';
import 'package:shopping_list/ui/items_screen.dart';
import 'package:shopping_list/ui/shopping_list_dialog.dart';
import 'package:shopping_list/util/dbhelper.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DbHelper helper = DbHelper();
    // helper.testDb();

    return MaterialApp(
        title: "Shopping List",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ShowList());
  }
}

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  DbHelper helper = DbHelper();

  List<ShoppingList> shoppingList = [];
  late ShoppingListDialog dialog;
  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();

    return Scaffold(
      appBar: AppBar(
        title: Text("My shopping list")
      ),
      body: ListView.builder(
        itemCount: (shoppingList != null) ? shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(shoppingList[index].name),
            leading: CircleAvatar(
              child: Text(shoppingList[index].priority.toString()),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog!
                        .buildDialog(context, shoppingList[index], false));
              },
            ),
            onTap: (){
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => 
                ItemsScreen(shoppingList[index])));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) => dialog!
              .buildDialog(context, ShoppingList(0, '', 0), true));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
        ),
    );
  }

  Future showData() async {
    await helper.openDb();

    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}
