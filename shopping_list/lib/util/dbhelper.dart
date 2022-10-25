import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'bdcompras.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        database.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id)');
      }, version: version);
    }
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
}
