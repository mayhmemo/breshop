import 'package:breshop/data/database_provider.dart';
import 'package:breshop/data/models/item.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ItemRepository {
  static Future<void> insertItem(Item item) async {
    final db = await DatabaseProvider().database;
    await db.insert(
      'Item',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Item>> getAllItems() async {
    final db = await DatabaseProvider().database;
    final List<Map<String, dynamic>> maps = await db.query('Item');
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        imagePath: maps[i]['imagePath'],
        price: maps[i]['price'],
        categoryId: maps[i]['categoryId'],
        size: maps[i]['size'],
        condition: maps[i]['condition'],
      );
    });
  }

  static Future<Item> getItemById(int id) async {
    final db = await DatabaseProvider().database;
    final List<Map<String, dynamic>> maps =
        await db.query('Item', where: 'id = ?', whereArgs: [id]);
    return Item(
      id: maps[0]['id'],
      name: maps[0]['name'],
      description: maps[0]['description'],
      imagePath: maps[0]['imagePath'],
      price: maps[0]['price'],
      categoryId: maps[0]['categoryId'],
      size: maps[0]['size'],
      condition: maps[0]['condition'],
    );
  }

  static Future<List<Item>> getItemsByCategoryId(int categoryId) async {
    final db = await DatabaseProvider().database;
    final List<Map<String, dynamic>> maps = await db
        .query('Item', where: 'categoryId = ?', whereArgs: [categoryId]);
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        imagePath: maps[i]['imagePath'],
        price: maps[i]['price'],
        categoryId: maps[i]['categoryId'],
        size: maps[i]['size'],
        condition: maps[i]['condition'],
      );
    });
  }

  static Future<void> updateItem(Item item) async {
    final db = await DatabaseProvider().database;
    await db.update(
      'Item',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseProvider().database;
    await db.delete(
      'Item',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
