import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_out/features/home/data/models/category_model.dart';
import '../../data/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('task.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        priority TEXT,
        category TEXT,
        imagePath TEXT,
        isDone INTEGER DEFAULT 0  -- Adding the new column isDone
      )
    ''');

    await db.execute('''
      CREATE TABLE categories(
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT
      )
    ''');
  }

  // Migration logic to handle version upgrades
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Adding the `isDone` column to the tasks table for existing databases
      await db.execute('ALTER TABLE tasks ADD COLUMN isDone INTEGER DEFAULT 0');
    }
  }

  // ------------ Tasks CRUD ------------
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // ------------ Categories CRUD ------------
  Future<void> insertCategory(Category category) async {
    final db = await database;
    await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    final result = await db.query('categories');
    return result.map((json) => Category.fromMap(json)).toList();
  }

  Future<void> deleteCategory(String id) async {
    final db = await database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
