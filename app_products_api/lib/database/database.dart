import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Products extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().named('name')();
  TextColumn get image => text()();
  TextColumn get imageType => text()();
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

@DriftDatabase(tables: [Products])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(openConnection());
  @override
  int get schemaVersion => 1;
  //CRUD
  Future<List<Product>> getProducts() async {
    return await select(products).get();
  }

  Future<int> insertProduct(ProductsCompanion productsCompanion) async {
    print("here lets insert!");
    return await into(products).insert(productsCompanion);
  }

  Future<List<Product>> getByProductId(int productId) {
    return (select(products)..where((product) => product.id.equals(productId)))
        .get();
  }

  Future<int> deleteProduct(ProductsCompanion productsCompanion) async {
    print("deleting...");
    return await delete(products).delete(productsCompanion);
  }

  Future<bool> updateProduct(ProductsCompanion productsCompanion) async {
    return await update(products).replace(productsCompanion);
  }
}
