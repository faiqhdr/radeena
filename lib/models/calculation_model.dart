//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CalculationModel {
  // Create Single Instance of Class
  static final CalculationModel _instance = CalculationModel._internal();
  static Database? _database;

  factory CalculationModel() {
    return _instance;
  }

  CalculationModel._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize Database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'calculation_history.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  // Create History Table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calculationName TEXT,
        totalProperty REAL,
        propertyAmount REAL,
        debtAmount REAL,
        testamentAmount REAL,
        funeralAmount REAL,
        selectedHeirs TEXT,
        distribution TEXT,
        divisionStatus TEXT,
        finalShare INTEGER
      )
    ''');
  }

  // Save Calculation
  Future<void> saveCalculation(
    String calculationName,
    double totalProperty,
    double propertyAmount,
    double debtAmount,
    double testamentAmount,
    double funeralAmount,
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
        'propertyAmount': propertyAmount,
        'debtAmount': debtAmount,
        'testamentAmount': testamentAmount,
        'funeralAmount': funeralAmount,
        'selectedHeirs': selectedHeirs.toString(),
        'distribution': distribution.toString(),
        'divisionStatus': divisionStatus,
        'finalShare': finalShare,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve Calculation
  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history');
  }

  // Delete Calculation by ID
  Future<void> deleteHistory(int id) async {
    final db = await database;
    await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
