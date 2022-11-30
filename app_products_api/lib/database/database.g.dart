// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String title;
  final String image;
  final String imageType;
  const Product(
      {required this.id,
      required this.title,
      required this.image,
      required this.imageType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(title);
    map['image'] = Variable<String>(image);
    map['image_type'] = Variable<String>(imageType);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      title: Value(title),
      image: Value(image),
      imageType: Value(imageType),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      image: serializer.fromJson<String>(json['image']),
      imageType: serializer.fromJson<String>(json['imageType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'image': serializer.toJson<String>(image),
      'imageType': serializer.toJson<String>(imageType),
    };
  }

  Product copyWith(
          {int? id, String? title, String? image, String? imageType}) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        imageType: imageType ?? this.imageType,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('imageType: $imageType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, image, imageType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.title == this.title &&
          other.image == this.image &&
          other.imageType == this.imageType);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> image;
  final Value<String> imageType;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
    this.imageType = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String image,
    required String imageType,
  })  : title = Value(title),
        image = Value(image),
        imageType = Value(imageType);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? image,
    Expression<String>? imageType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'name': title,
      if (image != null) 'image': image,
      if (imageType != null) 'image_type': imageType,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? image,
      Value<String>? imageType}) {
    return ProductsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      imageType: imageType ?? this.imageType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['name'] = Variable<String>(title.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (imageType.present) {
      map['image_type'] = Variable<String>(imageType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('imageType: $imageType')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageTypeMeta =
      const VerificationMeta('imageType');
  @override
  late final GeneratedColumn<String> imageType = GeneratedColumn<String>(
      'image_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, image, imageType];
  @override
  String get aliasedName => _alias ?? 'products';
  @override
  String get actualTableName => 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['name']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('image_type')) {
      context.handle(_imageTypeMeta,
          imageType.isAcceptableOrUnknown(data['image_type']!, _imageTypeMeta));
    } else if (isInserting) {
      context.missing(_imageTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      imageType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_type'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $ProductsTable products = $ProductsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [products];
}
