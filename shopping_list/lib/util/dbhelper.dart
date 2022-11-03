import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  static final DbHelper dbHelper = DbHelper.internal();
  DbHelper.internal();
  factory DbHelper() {
    return dbHelper;
  }

  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), 'bdcompras.db'),
        onCreate: (database, version) {
      database.execute(
          'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
      database.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id))');
    }, version: version);
    return db!;
  }

  Future testDb() async {
    db = await openDb();

    await db!.execute('INSERT INTO lists VALUES (0, "Memorias", 1)');
    await db!.execute(
        'INSERT INTO items VALUES (0, 0, "Memorias DDR 3", "20 unds", "Kingstone")');

    List list = await db!.rawQuery('SELECT * FROM lists');
    List items = await db!.rawQuery('SELECT * FROM items');
  }

  //CRUD methods
  //insert list
  Future<int> insertList(ShoppingList list) async {
    int id = await db!.insert('lists', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //insert item
  Future<int> insertItem(ListItems item) async {
    int id = await db!.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //listar tabla "lists"
  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('lists');

    return List.generate(maps.length, (i) {
      return ShoppingList(
        maps[i]['id'], 
        maps[i]['name'], 
        maps[i]['priority']);
    });
  }


    //listar tabla "items"
  Future<List<ListItems>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps = await db!.query('items', where: 'idList = ?', whereArgs: [idList]);

    return List.generate(maps.length, (i) {
      return ListItems(
        maps[i]['id'], 
        maps[i]['idList'], 
        maps[i]['name'],
        maps[i]['quantity'],
        maps[i]['note']
        );
    });
  }
}
