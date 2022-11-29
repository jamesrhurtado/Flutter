import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_items.dart';
import 'package:shopping_list/util/dbhelper.dart';

import '../models/shopping_list.dart';

class ListItemDialog {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

// isNew: false: edit / true: new
  Widget buildDialog(BuildContext context, ListItems item, bool isNew) {
    DbHelper helper = DbHelper();

    if (!isNew){
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }

    else{
      txtName.text = "";
      txtQuantity.text = "";
      txtNote.text = "";
    }

    return AlertDialog(
      title: Text((isNew) ? "New Shopping List" : "Edit shopping list"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: txtQuantity,
              decoration: const InputDecoration(hintText: "Quantity"),
            ),
            TextField(
              controller: txtNote,
              decoration: const InputDecoration(hintText: "Note"),
            ),
            ElevatedButton(
                onPressed: () {
                  item.name = txtName.text;
                  item.quantity = txtQuantity.text;
                  item.note = txtNote.text;
                  helper.insertItem(item);
                  Navigator.pop(context);
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
