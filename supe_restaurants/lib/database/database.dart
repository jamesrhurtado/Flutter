import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Restaurants extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().named('name')();
  TextColumn get poster => text()();
  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Restaurants])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(openConnection());
  @override
  int get schemaVersion => 1;
  //CRUD
  Future<List<Restaurant>> getProducts() async {
    return await select(restaurants).get();
  }

  Future<int> insertProduct(RestaurantsCompanion restaurantsCompanion) async {
    return await into(restaurants).insert(restaurantsCompanion);
  }

  Future<int> deleteProduct(RestaurantsCompanion restaurantsCompanion) async {
    return await delete(restaurants).delete(restaurantsCompanion);
  }

  Future<bool> updateProduct(RestaurantsCompanion restaurantsCompanion) async {
    return await update(restaurants).replace(restaurantsCompanion);
  }
}
