import 'package:breshop/data/models/item.dart';
import 'package:faker/faker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _databaseName = 'bubble_database.db';
  static const _databaseVersion = 2;

  DatabaseProvider._();
  static final DatabaseProvider instance = DatabaseProvider._();

  factory DatabaseProvider() => instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    deleteDatabase(path);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Category (
        id INTEGER PRIMARY KEY,
        name TEXT
      )''');

    await db.execute('''
      CREATE TABLE Item (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        imagePath TEXT,
        price REAL,
        categoryId INTEGER,
        size TEXT,
        condition TEXT
      )''');

    await _prePopulateCategories(db);
    await _prePopulateItems(db);
  }

  Future<void> _prePopulateCategories(Database db) async {
    await db.insert(
      'Category',
      {'id': 1, 'name': 'Shoes'},
    );
    await db.insert(
      'Category',
      {'id': 2, 'name': 'Hoodies'},
    );
    await db.insert(
      'Category',
      {'id': 3, 'name': 'T-Shirts'},
    );
    await db.insert(
      'Category',
      {'id': 4, 'name': 'Pants'},
    );
    await db.insert(
      'Category',
      {'id': 5, 'name': 'Accessories'},
    );
  }

  Future<void> _prePopulateItems(Database db) async {
    List<Item> items = [];
    // Generate fake items using Faker
    final random = RandomGenerator();
    final faker = Faker.withGenerator(random);
    for (var i = 0; i < 8; i++) {
      items.add(Item(
        name: faker.lorem.word(),
        description: faker.lorem.sentence(),
        price: random.decimal(scale: 2, min: 10.00),
        categoryId: random.integer(5),
        size: random.string(2),
        condition: faker.lorem.word(),
        imagePath: 'assets/images/hoodie.jpg',
      ));
    }

    for (var item in items) {
      await db.insert(
        'Item',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
