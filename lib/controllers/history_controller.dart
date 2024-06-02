import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryController {
  static final HistoryController _instance = HistoryController._internal();
  static Database? _database;

  factory HistoryController() {
    return _instance;
  }

  HistoryController._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'calculation_history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calculationName TEXT,
        totalProperty REAL,
        selectedHeirs TEXT,
        distribution TEXT,
        divisionStatus TEXT,
        finalShare INTEGER
      )
    ''');
  }

  Future<void> saveCalculation(
    String calculationName,
    double totalProperty,
    Map<String, int> selectedHeirs,
    Map<String, double> distribution,
    String divisionStatus,
    int finalShare,
  ) async {
    final db = await database;
    await db.insert(
      'history',
      {
        'calculationName': calculationName,
        'totalProperty': totalProperty,
        'selectedHeirs': selectedHeirs.toString(),
        'distribution': distribution.toString(),
        'divisionStatus': divisionStatus,
        'finalShare': finalShare,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history');
  }

  Future<void> deleteHistory(int id) async {
    final db = await database;
    await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
