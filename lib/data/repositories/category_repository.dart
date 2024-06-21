import 'package:breshop/data/database_provider.dart';
import 'package:breshop/data/models/category.dart';

class CategoryRepository {
  static Future<List<Category>> getAllCategories() async {
    final db = await DatabaseProvider().database;
    final List<Map<String, dynamic>> maps = await db.query('Category');
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  static Future<Category> getCategoryById(int id) async {
    final db = await DatabaseProvider().database;
    final List<Map<String, dynamic>> maps =
        await db.query('Category', where: 'id = ?', whereArgs: [id]);
    return Category(
      id: maps[0]['id'],
      name: maps[0]['name'],
    );
  }
}
