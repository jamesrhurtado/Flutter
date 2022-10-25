import 'package:flutter/material.dart';
import 'package:shopping_list/util/dbhelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.testDb();

    return Container();
  }
}
